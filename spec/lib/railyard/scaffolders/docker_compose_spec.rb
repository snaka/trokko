# frozen_string_literal: true

require 'railyard/scaffolders/docker_compose'

RSpec.describe Railyard::Scaffolders::DockerCompose do
  describe '#generate' do
    subject { described_class.new(db:).generate }

    context 'when db is MySQL' do
      let(:db) { 'mysql' }

      it { is_expected.to include 'image: mysql:latest' }
    end

    context 'when db is PostgreSQL' do
      let(:db) { 'postgresql' }

      it { is_expected.to include 'image: postgres:latest' }
    end
  end
end
