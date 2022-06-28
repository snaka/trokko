# frozen_string_literal: true

require 'railyard/scaffolders/gemfile'

RSpec.describe Railyard::Scaffolders::Gemfile do
  xdescribe '#generate' do
    subject { described_class.new.generate }

    it { is_expected.not_to be_nil }

    context 'when Rails version is specified' do
      subject { described_class.new(rails_version: '6.1.0').generate }

      it { is_expected.to include "gem 'rails', '~>6.1.0'" }
    end

    context 'when Rails version is not specified' do
      it { is_expected.to include "gem 'rails', '~>7.0.0'" }
    end
  end
end
