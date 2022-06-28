# frozen_string_literal: true

module Railyard
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

      # def generate
      #   <<~ENTRYPOINT
      #     #!/usr/bin/env bash
      #     set -e
      #     set -u
      #     set -o pipefail

      #     bundle install

      #     # Remove a potentially pre-existing server.pid for Rails.
      #     rm -f /app/tmp/pids/server.pid

      #     # Then exec the container's main process (what's set as CMD in the Dockerfile).
      #     exec "$@"
      #   ENTRYPOINT
      # end
    end
  end
end
