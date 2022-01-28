# frozen_string_literal: true

require 'services/auth_service'

RSpec.describe AuthService do
  describe '.perform' do
    context 'with correct credentials' do
      let(:response) { described_class.perform(email: AuthService::EMAIL, password: AuthService::PASSWORD) }

      it 'has no errors' do
        expect(response.errors.size.zero?).to eq(true)
      end

      it 'returns true for success?' do
        expect(response.success?).to eq(true)
      end

      it 'returns false for failure?' do
        expect(response.failure?).to eq(false)
      end
    end

    context 'with incorrect credentials' do
      let(:response) { described_class.perform(email: AuthService::EMAIL, password: 'wrong') }

      it 'has errors' do
        expect(response.errors.size.positive?).to eq(true)
      end

      it 'returns false for success?' do
        expect(response.success?).to eq(false)
      end

      it 'returns true for failure?' do
        expect(response.failure?).to eq(true)
      end

      it 'reports about errors' do
        expect(response.errors[:credentials]).to include('invalid')
      end
    end

    context 'with missing credentials' do
      let(:response) { described_class.perform }

      it 'has errors' do
        expect(response.errors.size.positive?).to eq(true)
      end

      it 'reports about missing email' do
        expect(response.errors[:email]).to include('can\'t be blank')
      end

      it 'reports about missing password' do
        expect(response.errors[:password]).to include('can\'t be blank')
      end
    end
  end

  describe '.perform!' do
    context 'with success' do
      let(:response) { described_class.perform!(email: AuthService::EMAIL, password: AuthService::PASSWORD) }

      it 'does not raise an exception' do
        expect { response }.not_to raise_error
      end
    end

    context 'with failure' do
      let(:response) { described_class.perform!(email: AuthService::EMAIL) }

      it 'raises an exception' do
        expect { response }.to raise_error(ServiceRecord::Failure)
      end
    end
  end
end
