# frozen_string_literal: true

module RailsOnDockerStarter
  module Scaffolders
    # Generating docker-compose file according to configuration
    class DockerCompose
      def initialize(config = {})
        @config = config
      end

      def dbms
        @config[:dbms] || :mysql
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
volumes:
  database:
    driver: local
  bundle:
    driver: local
        DOCKER_COMPOSE
        # rubocop:enable Layout/HeredocIndentation
      end

      private

      def db_service_config
        db_service =
          case dbms
          when :mysql
            MySQLService.new
          when :postgres
            PostgreSQLService.new
          else
            raise "Specified DBMS is not supported : #{dbms}"
          end
        db_service.generate
      end

      # MySQL configuration
      class MySQLService
        def generate
          <<-DB_SERVICE.chomp
    image: mysql:latest
    cap_add:
      - SYS_NICE
    environment:
      MYSQL_ROOT_PASSWORD: secret
      TZ: Asia/Tokyo
    volumes:
      - database:/var/lib/mysql
          DB_SERVICE
        end
      end

      # PostgreSQL configuration
      class PostgreSQLService
        def generate
          <<-DB_SERVICE.chomp
    image: postgres:latest
    environment:
      POSTGRES_HOST_AUTH_METHOD: trust
    volumes:
      - database:/var/lib/postgresql/data
          DB_SERVICE
        end
      end
    end
  end
end
