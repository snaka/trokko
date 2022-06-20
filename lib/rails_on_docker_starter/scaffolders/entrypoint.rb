# frozen_string_literal: true

module RailsOnDockerStarter
  module Scaffolders
    # Generating entrypoint.sh file according to configurations
    class Entrypoint
      def generate
        <<~ENTRYPOINT
          #!/usr/bin/env bash
          set -e
          set -u
          set -o pipefail

          bundle install

          # Remove a potentially pre-existing server.pid for Rails.
          rm -f /app/tmp/pids/server.pid

          # Then exec the container's main process (what's set as CMD in the Dockerfile).
          exec "$@"
        ENTRYPOINT
      end
    end
  end
end
