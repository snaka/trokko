# frozen_string_literal: true

module Trokko
  module Scaffolders
    # Generating entrypoint.sh file according to configurations
    class Entrypoint
      attr_reader :thor

      def initialize(thor:)
        @thor = thor
      end

      def generate
        thor.template(
          'templates/entrypoint.sh.erb',
          "#{thor.name}/entrypoint.sh",
          force: true,
          context: binding
        )
      end
    end
  end
end
