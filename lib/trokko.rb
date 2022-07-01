# frozen_string_literal: true

require_relative 'trokko/version'
require_relative 'trokko/scaffolders/dockerfile'
require_relative 'trokko/scaffolders/docker_compose'
require_relative 'trokko/scaffolders/gemfile'
require_relative 'trokko/scaffolders/entrypoint'
require_relative 'trokko/scaffolders/config/database'

module Trokko
  class Error < StandardError; end
  # Your code goes here...
end
