# frozen_string_literal: true

module Railyard
  module Scaffolders
    module Config
      # Generating config/database.yml file according to configurations
      class Database
        attr_reader :db

        def initialize(db:)
          @db = db
        end

        def generate
          # rubocop:disable Layout/HeredocIndentation
          <<-DATABASE
default: &default
#{db_config}
  host: db
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: app_development

test:
  <<: *default
  database: app_test

production:
  <<: *default
  database: app_production
  username: app
  password: <%= ENV["APP_DATABASE_PASSWORD"] %>
          DATABASE
          # rubocop:enable Layout/HeredocIndentation
        end

        private

        def db_config
          db_config =
            case db
            when 'mysql'
              MySQLConfig.new
            when 'postgres'
              PostgreSQLConfig.new
            else
              raise "Specified db is not supported : #{db}"
            end
          db_config.generate
        end
      end

      # MySQL configuration
      class MySQLConfig
        def generate
          <<-DB_CONFIG.chomp
  adapter: mysql2
  encoding: utf8
  username: root
  password: <%= ENV.fetch("MYSQL_ROOT_PASSWORD") %>
          DB_CONFIG
        end
      end

      # PostgreSQL configuration
      class PostgreSQLConfig
        def generate
          <<-DB_CONFIG.chomp
  adapter: postgresql
  encoding: unicode
  user: postgres
          DB_CONFIG
        end
      end
    end
  end
end
