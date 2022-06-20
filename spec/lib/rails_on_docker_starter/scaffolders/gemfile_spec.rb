# frozen_string_literal: true

require 'rails_on_docker_starter/scaffolders/gemfile'

RSpec.describe RailsOnDockerStarter::Scaffolders::Gemfile do
  describe '#generate' do
    subject { described_class.new.generate }

    it 'generates a Gemfile' do
      expect(subject).not_to be_nil
    end

    context 'when Rails version is specified' do
      subject { described_class.new(rails_version: '6.1.0').generate }

      it 'generates a Gemfile with the specified Rails version' do
        expect(subject).to include("gem 'rails', '~>6.1.0'")
      end
    end

    context 'when Rails version is not specified' do
      it 'outputs a Rails version as 7.0.0' do
        expect(subject).to include("gem 'rails', '~>7.0.0'")
      end
    end
  end
end
