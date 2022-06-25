# frozen_string_literal: true

require 'railyard/scaffolders/entrypoint'

RSpec.describe Railyard::Scaffolders::Entrypoint do
  describe '#generate' do
    subject { described_class.new.generate }

    it { is_expected.not_to be_nil }
  end
end
