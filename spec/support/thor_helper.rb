# frozen_string_literal: true

require 'thor'

module ThorHelper
  def thor_dummy
    thor_class = Class.new(Thor) do
      include Thor::Actions

      def self.source_root
        File.expand_path('../../lib/trokko', __dir__)
      end

      no_commands do
        def name
          'dummy'
        end
      end
    end
    thor_class.new
  end

  # Borrowed from:
  #   https://github.com/rails/thor/blob/main/spec/helper.rb
  # rubocop:disable Security/Eval
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new # $stdout = StringIO.new", nil, __FILE__, __LINE__
      yield
      result = eval("$#{stream} # $stdout", nil, __FILE__, __LINE__).string
    ensure
      eval "$#{stream} = #{stream.upcase} # $stdout = STDOUT", nil, __FILE__, __LINE__
    end

    result
  end
  # rubocop:enable Security/Eval
end

RSpec.configure do |config|
  config.include ThorHelper
end
