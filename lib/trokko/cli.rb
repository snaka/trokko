# frozen_string_literal: true

require 'fileutils'
require 'thor'
require 'trokko'

module Trokko
  # Generate rails application
  class Generate < Thor::Group
    include Thor::Actions

    desc 'Generate rails application on docker'

    argument :name, type: :string, required: false

    class_option :ruby_version, default: 'latest', desc: 'Ruby version (docker image tag)'
    class_option :db, default: 'mysql', enum: %w[mysql postgresql], desc: 'DBMS to use'
    class_option :skip_build, type: :boolean, default: false, desc: 'Skip build'
    class_option :force, type: :boolean, default: false, desc: 'Force to execute'

    def self.source_root
      File.dirname(__FILE__)
    end

    def ask_project_name
      @name = ask('Project name:') unless name
      return unless @name.empty?

      CLI.command_help(shell, 'generate')
      say 'Stop executing task', :red
      raise Thor::InvocationError, '[ERROR] Project name is required'
    end

    def confirm
      say "- Project name: #{name}", :cyan
      say "- Ruby version: #{ruby_version}", :cyan
      say "- Database: #{db}", :cyan

      return if ask('Are you sure to execute the settings described above?', limited_to: %w[y n]) == 'y'

      say 'Stop executing task', :red
      raise Thor::InvocationError, 'You choose *NOT* to execute.'
    end

    def check_directory
      say 'check directory...', :yellow
      say File.exist?(name)
      return unless File.exist?(name)
      FileUtils.remove_dir(name) and return if force

      say 'Stop executing task', :red
      raise Thor::InvocationError,
            "[ERROR] Directory '#{name}' already exists. " \
            "If you are sure executing is OK, specify the '--force' option. The directory will be removed."
    end

    def dockerfile
      say 'Generating Dockerfile...', :yellow
      Scaffolders::Dockerfile.new(ruby_version: ruby_version, db: db, thor: self).generate
      Scaffolders::Entrypoint.new(thor: self).generate
    end

    def gemfile
      say 'Generating Gemfile...', :yellow
      Scaffolders::Gemfile.new(rails_version: '7.0.0', thor: self).generate
      inside name do
        FileUtils.touch 'Gemfile.lock'
      end
    end

    def docker_compose
      say 'Generating docker-compose.yml...', :yellow
      Scaffolders::DockerCompose.new(db: db, thor: self).generate
    end

    def rails_new
      say 'Generating rails application...', :yellow
      inside name do
        unless system(
          "docker compose run --no-deps --entrypoint '' --rm app" \
          " bundle exec rails new . --database=#{db} --force"
        )
          say 'Stop executing task', :red
          raise Thor::InvocationError, '[ERROR] Failed to generate rails application'
        end

        next if File.stat('config').uid == uid

        unless system(
          "docker compose run --no-deps --entrypoint '' --rm app" \
          " chown -R #{uid}:#{gid} ."
        )
          say 'Stop executing task', :red
          raise Thor::InvocationError, '[ERROR] Failed to change owner of generated files'
        end
      end
    end

    def post_rails_new
      say 'Generating database.yml...', :yellow
      Scaffolders::Config::Database.new(db: db, thor: self).generate
    end

    def docker
      return if skip_build

      say 'Building docker image...', :yellow
      inside name do
        next if system('docker compose build')

        say 'Stop executing task', :red
        raise Thor::InvocationError, '[ERROR] Failed to build docker image'
      end
    end

    def finished
      say 'Finished!', :green
    end

    private

    def force
      options[:force]
    end

    def ruby_version
      options[:ruby_version]
    end

    def db
      options[:db]
    end

    def skip_build
      options[:skip_build]
    end

    def uid
      Process.uid
    end

    def gid
      Process.gid
    end
  end

  # CLI for Trokko
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    register(Generate, 'generate', 'generate [NAME]', 'Generate a Rails application with the specified name')
    tasks['generate'].options = Generate.class_options

    desc 'version', 'Show version'
    def version
      say "trokko #{Trokko::VERSION}"
    end
    map %w[-v --version] => :version
  end
end
