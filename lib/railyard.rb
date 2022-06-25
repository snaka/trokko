# frozen_string_literal: true

require_relative 'railyard/version'
require_relative 'railyard/scaffolders/dockerfile'
require_relative 'railyard/scaffolders/docker_compose'
require_relative 'railyard/scaffolders/gemfile'
require_relative 'railyard/scaffolders/entrypoint'
require_relative 'railyard/scaffolders/config/database'

module Railyard
  class Error < StandardError; end
  # Your code goes here...
end
