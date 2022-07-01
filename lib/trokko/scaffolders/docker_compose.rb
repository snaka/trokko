# frozen_string_literal: true

module Trokko
  module Scaffolders
    # Generating docker-compose file according to configuration
    class DockerCompose
      attr_reader :db, :thor

      def initialize(db:, thor:)
        @db = db
        @thor = thor
      end

      def generate
        thor.template(
          'templates/docker-compose.yml.erb',
          "#{thor.name}/docker-compose.yml",
          force: true,
          context: binding
        )
      end

      private

      def db_service_config
        erb_source = File.read("#{source_root}/templates/docker_compose/#{db}/db_service.erb")
        ERB.new(erb_source).result(binding)
      end

      def app_service_config
        erb_source = File.read("#{source_root}/templates/docker_compose/#{db}/app_service.erb")
        ERB.new(erb_source).result(binding)
      end

      def source_root
        thor.class.source_root
      end

      def project_name
        thor.name
      end
    end
  end
end
