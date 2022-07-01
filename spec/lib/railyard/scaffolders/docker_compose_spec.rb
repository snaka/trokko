# frozen_string_literal: true

require 'railyard/scaffolders/docker_compose'

RSpec.describe Railyard::Scaffolders::DockerCompose do
  describe '#generate' do
    subject { described_class.new(db:, thor:).generate }

    include_context 'within temp dir'

    let(:db) { 'mysql' }
    let(:thor) { thor_dummy }

    it { is_expected.to eq 'dummy/docker-compose.yml' }
    it { is_expected.to be_a_file_with 'image: mysql:latest' }

    context 'when db is PostgreSQL' do
      let(:db) { 'postgresql' }

      it { is_expected.to be_a_file_with 'image: postgres:latest' }
    end
  end
end
