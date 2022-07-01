# frozen_string_literal: true

module Trokko
  module Scaffolders
    module Config
      # Generating config/database.yml file according to configurations
      class Database
        attr_reader :db, :thor

        def initialize(db:, thor:)
          @db = db
          @thor = thor
        end

        def generate
          thor.template(
            'templates/config/database.yml.erb',
            "#{thor.name}/config/database.yml",
            force: true,
            context: binding
          )
        end

        private

        def db_config
          erb_source = File.read("#{source_root}/templates/config/database/#{db}.yml.erb")
          ERB.new(erb_source).result(binding)
        end

        def source_root
          thor.class.source_root
        end
      end
    end
  end
end
