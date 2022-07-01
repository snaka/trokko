# frozen_string_literal: true

module Railyard
  module Scaffolders
    # Generationg Gemfile according to configurations
    class Gemfile
      attr_reader :rails_version, :thor

      def initialize(rails_version:, thor:)
        @rails_version = rails_version
        @thor = thor
      end

      def generate
        thor.template(
          'templates/Gemfile.erb',
          "#{thor.name}/Gemfile",
          force: true,
          context: binding
        )
      end
    end
  end
end
