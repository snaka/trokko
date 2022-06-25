# frozen_string_literal: true

module Railyard
  module Scaffolders
    # Generating docker-compose file according to configuration
    class DockerCompose
      attr_reader :db

      def initialize(db:)
        @db = db
      end

      def generate
        # rubocop:disable Layout/HeredocIndentation
        <<-DOCKER_COMPOSE
version: '3'
services:
  db:
#{db_service_config}
  app:
    build: .
    volumes:
      - .:/app
      - bundle:/usr/local/bundle
    ports:
      - "3000:3000"
    depends_on:
      - db
#{app_service_config}
volumes:
  database:
    driver: local
  bundle:
    driver: local
        DOCKER_COMPOSE
        # rubocop:enable Layout/HeredocIndentation
      end

      private

      def db_service
        @db_service ||=
          case db
          when 'mysql'
            MySQLService.new
          when 'postgres'
            PostgreSQLService.new
          else
            raise "Specified db is not supported : #{db}"
          end
      end

      def db_service_config
        db_service.db_service_config
      end

      def app_service_config
        db_service.app_service_config
      end

      # MySQL configuration
      class MySQLService
        def db_service_config
          <<-DB_SERVICE.chomp
    image: mysql:latest
    cap_add:
      - SYS_NICE
    environment:
      MYSQL_ROOT_PASSWORD: &db_password secret
      TZ: Asia/Tokyo
    volumes:
      - database:/var/lib/mysql
          DB_SERVICE
        end

        def app_service_config
          <<-APP_SERVICE.chomp
    environment:
      MYSQL_ROOT_PASSWORD: *db_password
          APP_SERVICE
        end
      end

      # PostgreSQL configuration
      class PostgreSQLService
        def db_service_config
          <<-DB_SERVICE.chomp
    image: postgres:latest
    environment:
      POSTGRES_HOST_AUTH_METHOD: trust
    volumes:
      - database:/var/lib/postgresql/data
          DB_SERVICE
        end

        def app_service_config; end
      end
    end
  end
end
