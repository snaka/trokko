# frozen_string_literal: true

module Railyard
  module Scaffolders
    # Generating Dockerfile according to configurations
    class Dockerfile
      attr_reader :ruby_version, :db

      def initialize(ruby_version:, db:)
        @ruby_version = ruby_version
        @db = db
      end

      def generate
        <<~DOCKERFILE
          FROM ruby:#{ruby_version}

          RUN apt-get update -qq && apt-get install -y build-essential #{db_dependencies}
          RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
            apt-get install -y nodejs
          RUN mkdir /app
          WORKDIR /app
          COPY Gemfile /app/Gemfile
          COPY Gemfile.lock /app/Gemfile.lock
          RUN gem update bundler && bundle install
          COPY . /app

          COPY entrypoint.sh /usr/bin/
          RUN chmod +x /usr/bin/entrypoint.sh
          ENTRYPOINT ["entrypoint.sh"]
          EXPOSE 3000

          CMD ["bundle", "exec", "rails", "server", "--binding", "0.0.0.0"]
        DOCKERFILE
      end

      private

      def db_dependencies
        case db
        when 'mysql'
          ''
        when 'postgres'
          'libpq-dev'
        end
      end
    end
  end
end
