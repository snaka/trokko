# frozen_string_literal: true

require 'fileutils'
require 'thor'
require 'trokko'
require 'trokko/command/generate'

module Trokko
  # CLI for Trokko
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    register(Trokko::Command::Generate, 'generate', 'generate [NAME]', 'Generate a Rails application with the specified name')
    tasks['generate'].options = Trokko::Command::Generate.class_options

    desc 'version', 'Show version'
    def version
      say "trokko #{Trokko::VERSION}"
    end
    map %w[-v --version] => :version
  end
end
