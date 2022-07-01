# frozen_string_literal: true

require 'thor'
require 'trokko/scaffolders/gemfile'

RSpec.describe Trokko::Scaffolders::Gemfile do
  describe '#generate' do
    subject { described_class.new(rails_version:, thor:).generate }

    include_context 'within temp dir'

    let(:rails_version) { '7.0.0' }
    let(:thor) { thor_dummy }

    it { is_expected.to eq 'dummy/Gemfile' }
    it { is_expected.to be_a_file_with "gem 'rails', '~>7.0.0'" }

    context 'when other Rails version is specified' do
      let(:rails_version) { '6.1.0' }

      it { is_expected.to be_a_file_with "gem 'rails', '~>6.1.0'" }
    end
  end
end
