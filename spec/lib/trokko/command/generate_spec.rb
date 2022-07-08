# frozen_string_literal: true

require 'trokko/command/generate'

RSpec.describe Trokko::Command::Generate do
  subject(:command) { described_class.new }

  describe '#ask_project_name' do
    let(:thor) { thor_dummy }

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
        allow(command).to receive(:ask).with('Project name:').and_return('dummy')
      end

      it 'sets project name' do
        command.ask_project_name
        expect(command.name).to eq('dummy')
      end
    end

    context 'when project name option is given' do
      before do
        command.name = 'dummy'
      end

      it 'does not ask for project name' do
        allow(command).to receive(:ask)
        command.ask_project_name
        expect(command).not_to have_received(:ask)
      end
    end
  end

  describe '#confirm' do
    before do
      command.name = 'project_name'
    end

    context 'when confirm answer is "y"' do
      before do
        allow(command).to receive(:ask).with(/Are you sure/, limited_to: %w[y n]).and_return('y')
      end

      it 'shows project name' do
        output = capture(:stdout) { command.confirm }
        expect(output).to include('- Project name: project_name')
      end
    end

    context 'when confirm answer is "n"' do
      before do
        allow(command).to receive(:ask).with(/Are you sure/, limited_to: %w[y n]).and_return('n')
      end

      it 'raises error' do
        expect do
          capture(:stdout) { command.confirm }
        end.to raise_error(Thor::InvocationError, 'You choose *NOT* to execute.')
      end
    end
  end

  describe '#check_directory' do
    context 'when directory exists' do
      it 'raises error'
    end

    context 'when directory exists and force option is given' do
      it 'removes directory'
    end

    context 'when directory does not exist' do
      it 'does not raise error'
    end
  end

  describe '#dockerfile' do
    it 'generates Dockerfile'
    it 'generates entrypoint'
  end

  describe '#gemfile' do
    it 'generates Gemfile'
    it 'generates Gemfile.lock'
  end

  describe '#docker_compose' do
    it 'generates docker-compose.yml'
  end

  describe '#rails_new' do
    it 'generates rails application'
    context 'when rails is failed' do
      it 'raises error'
    end

    context 'when file owner is not current user' do
      it 'change file owner'
    end
  end

  describe '#post_rails_new' do
    it 'config/database.yml is generated'
  end

  describe '#docker' do
    context 'when skip_build is true' do
      it 'does not build docker image'
    end

    context 'when skip_build is false' do
      it 'doex build docker image'
    end

    context 'when docker build fails' do
      it 'raises error'
    end
  end
end
