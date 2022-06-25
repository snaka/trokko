# frozen_string_literal: true

require 'railyard/scaffolders/dockerfile'

RSpec.describe Railyard::Scaffolders::Dockerfile do
  describe '#generate' do
    subject { described_class.new(ruby_version:, db:).generate }

    let(:ruby_version) { 'latest' }
    let(:db) { 'mysql' }

    context 'when db is MySQL' do
      it { is_expected.to include 'FROM ruby:latest' }
      it { is_expected.to include 'build-essential' }
      it { is_expected.not_to include 'libpq-dev' }
    end

    context 'when ruby_version is 3.1' do
      let(:ruby_version) { '3.1' }

      it { is_expected.to include 'FROM ruby:3.1' }
    end

    context 'when db is PostgreSQL' do
      let(:db) { 'postgres' }

      it { is_expected.to include 'FROM ruby:latest' }
      it { is_expected.to include 'build-essential' }
      it { is_expected.to include 'libpq-dev' }
    end
  end
end
