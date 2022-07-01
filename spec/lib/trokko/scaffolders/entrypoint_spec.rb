# frozen_string_literal: true

require 'trokko/scaffolders/entrypoint'

RSpec.describe Trokko::Scaffolders::Entrypoint do
  describe '#generate' do
    subject { described_class.new(thor:).generate }

    include_context 'within temp dir'

    let(:thor) { thor_dummy }

    it { is_expected.to eq 'dummy/entrypoint.sh' }
    it { is_expected.to be_a_file_with '#!/usr/bin/env bash' }
  end
end
