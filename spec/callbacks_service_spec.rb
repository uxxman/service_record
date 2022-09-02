# frozen_string_literal: true

require 'services/callbacks_service'

RSpec.describe CallbacksService do
  describe '.perform' do
    context 'with valid argument' do
      let(:response) { described_class.perform(param: 'valid') }

      it 'runs all callbacks in order' do
        expect(response.result).to eq(%i[before around_before perform after around_after])
      end
    end

    context 'with invalid argument' do
      let(:response) { described_class.perform(param: 'invalid') }

      it 'does not run any callbacks' do
        expect(response.result).to be_nil
      end
    end

    context 'with abort argument' do
      let(:response) { described_class.perform(param: 'abort') }

      it 'does not run any callbacks' do
        expect(response.result).to be_nil
      end
    end
  end
end
