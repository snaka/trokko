# frozen_string_literal: true

require 'rails_on_docker_starter/scaffolders/dockerfile'

RSpec.describe RailsOnDockerStarter::Scaffolders::Dockerfile do
  describe '#generate' do
    subject { described_class.new.generate }

    it 'generates a Dockerfile' do
      expect(subject).not_to be_nil
    end

    context 'when Ruby version is specified' do
      subject { described_class.new(ruby_version: '3.0').generate }

      it 'generates a Dockerfile with the specified Ruby version' do
        expect(subject).to include('FROM ruby:3.0')
      end
    end

    context 'when Ruby version is not specified' do
      it 'outputs a Ruby version as 3.1' do
        expect(subject).to include('FROM ruby:3.1')
      end
    end
  end
end
