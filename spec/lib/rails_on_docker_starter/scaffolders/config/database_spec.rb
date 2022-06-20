# frozen_string_literal: true

require 'rails_on_docker_starter/scaffolders/config/database'

RSpec.describe RailsOnDockerStarter::Scaffolders::Config::Database do
  describe '#generate' do
    subject { described_class.new.generate }

    it 'generates a config/database.yml file' do
      expect(subject).not_to be_nil
    end

    context 'when dbms is MySQL' do
      subject { described_class.new(dbms: :mysql).generate }

      it 'generates a config/database.yml file with MySQL' do
        expect(subject).to include('adapter: mysql2')
      end
    end

    context 'when dbms is PostgreSQL' do
      subject { described_class.new(dbms: :postgres).generate }

      it 'generates a config/database.yml file with PostgreSQL' do
        expect(subject).to include('adapter: postgresql')
      end
    end

    context 'when dbms is not specified' do
      it 'generates a config/database.yml file with MySQL' do
        expect(subject).to include('adapter: mysql2')
      end
    end
  end
end
