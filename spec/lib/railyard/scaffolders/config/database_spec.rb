# frozen_string_literal: true

require 'railyard/scaffolders/config/database'

RSpec.describe Railyard::Scaffolders::Config::Database do
  xdescribe '#generate' do
    subject { described_class.new(db:).generate }

    context 'when db is MySQL' do
      let(:db) { 'mysql' }

      it { is_expected.to include 'adapter: mysql2' }
    end

    context 'when db is PostgreSQL' do
      let(:db) { 'postgresql' }

      it { is_expected.to include 'adapter: postgresql' }
    end
  end
end
