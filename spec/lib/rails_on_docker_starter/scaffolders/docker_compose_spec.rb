# frozen_string_literal: true

require 'rails_on_docker_starter/scaffolders/docker_compose'

RSpec.describe RailsOnDockerStarter::Scaffolders::DockerCompose do
  describe '#generate' do
    subject { described_class.new.generate }

    it 'generates a docker-compose file' do
      expect(subject).not_to be_nil
    end

    context 'when dbms is MySQL' do
      subject { described_class.new(dbms: :mysql).generate }

      it 'generates a docker-compose file with MySQL' do
        expect(subject).to include('image: mysql:latest')
      end
    end

    context 'when dbms is PostgreSQL' do
      subject { described_class.new(dbms: :postgres).generate }

      it 'generates a docker-compose file with PostgreSQL' do
        expect(subject).to include('image: postgres:latest')
      end
    end

    context 'when dbms is not specified' do
      it 'generates a docker-compose file with MySQL' do
        expect(subject).to include('image: mysql:latest')
      end
    end
  end
end
