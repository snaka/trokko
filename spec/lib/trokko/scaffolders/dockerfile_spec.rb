# frozen_string_literal: true

require 'thor'
require 'trokko/scaffolders/dockerfile'

RSpec.describe Trokko::Scaffolders::Dockerfile do
  describe '#generate' do
    subject { described_class.new(ruby_version: ruby_version, db: db, thor: thor).generate }

    include_context 'within temp dir'

    let(:ruby_version) { 'latest' }
    let(:db) { 'mysql' }
    let(:thor) { thor_dummy }

    it { is_expected.to eq 'dummy/Dockerfile' }

    context 'when db is MySQL' do
      it { is_expected.to be_a_file_with 'FROM ruby:latest' }
      it { is_expected.to be_a_file_with 'build-essential' }
      it { is_expected.not_to be_a_file_with 'libpq-dev' }
    end

    context 'when ruby_version is 3.1' do
      let(:ruby_version) { '3.1' }

      it { is_expected.to be_a_file_with 'FROM ruby:3.1' }
    end

    context 'when db is PostgreSQL' do
      let(:db) { 'postgresql' }

      it { is_expected.to be_a_file_with 'FROM ruby:latest' }
      it { is_expected.to be_a_file_with 'build-essential' }
      it { is_expected.to be_a_file_with 'libpq-dev' }
    end
  end
end
