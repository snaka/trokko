# frozen_string_literal: true

require_relative 'lib/trokko/version'

Gem::Specification.new do |spec|
  spec.name = 'trokko'
  spec.version = Trokko::VERSION
  spec.authors = ['S.Nakamatsu']
  spec.email = ['19329+snaka@users.noreply.github.com']

  spec.summary = 'Set up a Rails development environment with Docker in 1 minute'
  spec.description = <<~DESCRIPTION
    The `trokko` command prepares the specified `Gemfile` template.
    It will prepare a `Dockerfile` or `docker-compose.yml` depending on the specified DBMS.
    Then, it runs `rails new` and gets you ready to start development right away.
    It takes about a minute.
  DESCRIPTION
  spec.homepage = 'https://github.com/snaka/trokko'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '~>1.2.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
