# frozen_string_literal: true

require 'rails_on_docker_starter/scaffolders/entrypoint'

RSpec.describe RailsOnDockerStarter::Scaffolders::Entrypoint do
  describe '#generate' do
    subject { described_class.new.generate }

    it 'generates an entrypoint file' do
      expect(subject).not_to be_nil
    end
  end
end
