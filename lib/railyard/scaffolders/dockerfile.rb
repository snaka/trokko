# frozen_string_literal: true

module Railyard
  module Scaffolders
    # Generating Dockerfile according to configurations
    class Dockerfile
      attr_reader :ruby_version, :db, :thor

      def initialize(ruby_version:, db:, thor:)
        @ruby_version = ruby_version
        @db = db
        @thor = thor
      end

      def generate
        thor.template(
          'templates/Dockerfile.erb',
          "#{thor.name}/Dockerfile",
          force: true,
          context: binding
        )
      end

      private

      def db_dependencies
        case db
        when 'mysql'
          ''
        when 'postgresql'
          'libpq-dev'
        else
          raise "Unknown database: #{db}"
        end
      end
    end
  end
end
