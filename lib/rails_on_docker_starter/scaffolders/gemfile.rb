# frozen_string_literal: true

module RailsOnDockerStarter
  module Scaffolders
    # Generationg Gemfile according to configurations
    class Gemfile
      def initialize(config = {})
        @config = config
      end

      def rails_version
        @config[:rails_version] || '7.0.0'
      end

      def generate
        <<~GEMFILE
          source 'https://rubygems.org'
          gem 'rails', '~>#{rails_version}'
        GEMFILE
      end
    end
  end
end
