# frozen_string_literal: true

require 'services/callbacks_service'

RSpec.describe CallbacksService do
  describe '.perform' do
    context 'with valid argument' do
      let(:response) { described_class.perform(param: 'valid') }

      it 'runs before callback' do
        expect(response.before_callback_called).to be(true)
      end

      it 'runs before around callback' do
        expect(response.around_before_callback_called).to be(true)
      end

      it 'runs after around callback' do
        expect(response.around_after_callback_called).to be(true)
      end

      it 'runs after callback' do
        expect(response.after_callback_called).to be(true)
      end
    end

    context 'with invalid argument' do
      let(:response) { described_class.perform(param: 'invalid') }

      it 'does not run before callback' do
        expect(response.before_callback_called).to be(false)
      end

      it 'does not run before around callback' do
        expect(response.around_before_callback_called).to be(false)
      end

      it 'does not run after around callback' do
        expect(response.around_after_callback_called).to be(false)
      end

      it 'does not run after callback' do
        expect(response.after_callback_called).to be(false)
      end
    end

    context 'with abort argument' do
      let(:response) { described_class.perform(param: 'abort') }

      it 'runs before callback' do
        expect(response.before_callback_called).to be(true)
      end

      it 'does not run before around callback' do
        expect(response.around_before_callback_called).to be(false)
      end

      it 'does not run after around callback' do
        expect(response.around_after_callback_called).to be(false)
      end

      it 'does not run after callback' do
        expect(response.after_callback_called).to be(false)
      end
    end
  end
end
