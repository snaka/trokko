# frozen_string_literal: true

require 'railyard/scaffolders/config/database'

RSpec.describe Railyard::Scaffolders::Config::Database do
  describe '#generate' do
    subject { described_class.new(db:, thor:).generate }

    include_context 'within temp dir'

    let(:db) { 'mysql' }
    let(:thor) { thor_dummy }

    it { is_expected.to eq 'dummy/config/database.yml' }
    it { is_expected.to be_a_file_with 'adapter: mysql2' }

    context 'when db is PostgreSQL' do
      let(:db) { 'postgresql' }

      it { is_expected.to be_a_file_with 'adapter: postgresql' }
    end
  end
end
