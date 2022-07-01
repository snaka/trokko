# frozen_string_literal: true

require 'thor'

module ThorHelper
  def thor_dummy
    thor_class = Class.new(Thor) do
      include Thor::Actions

      def self.source_root
        File.expand_path('../../lib/railyard', __dir__)
      end

      no_commands do
        def name
          'dummy'
        end
      end
    end
    thor_class.new
  end
end

RSpec.configure do |config|
  config.include ThorHelper
end
