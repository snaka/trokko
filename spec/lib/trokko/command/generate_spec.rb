# frozen_string_literal: true

require 'trokko/command/generate'

RSpec.describe Trokko::Command::Generate do
  describe '#ask_project_name' do
    let(:thor) { thor_dummy }
    let(:command) { described_class.new }

    context 'when project name is not specified and answer is empty' do
      before do
        allow(command).to receive(:ask).with('Project name:').and_return('')
      end

      it 'shows usage and exits' do
        expect do
          capture(:stdout) { command.ask_project_name }
        end.to raise_error(Thor::InvocationError, '[ERROR] Project name is required')
      end
    end

    context 'when asked project name is not empty' do
      before do
        allow(command).to receive(:ask).with('Project name:').and_return('project_name')
      end

      it 'sets project name' do
        command.ask_project_name
        expect(command.name).to eq('project_name')
      end
    end

    context 'when project name option is given' do
      before do
        allow(command).to receive(:name).and_return('project_name')
      end

      it 'does not ask for project name' do
        expect(command).not_to receive(:ask)
        command.ask_project_name
      end
    end
  end
end
