require 'services/authenticate_user'

RSpec.describe AuthenticateUser do
  describe '.perform' do
    context 'with correct credentials' do
      let(:response) { AuthenticateUser.perform(email: AuthenticateUser::EMAIL, password: AuthenticateUser::PASSWORD) }

      it 'has no errors' do
        expect(response.errors.size.zero?).to eq(true)
      end

      it 'returns a positive response' do
        expect(response.success?).to eq(true)
        expect(response.failure?).to eq(false)
      end

      it 'runs all defined callbacks' do
        expect(response.after_callback_called).to eq(true)
        expect(response.before_callback_called).to eq(true)
        expect(response.around_callback_called_after_yield).to eq(true)
        expect(response.around_callback_called_before_yield).to eq(true)
      end
    end

    context 'with incorrect credentials' do
      let(:response) { AuthenticateUser.perform(email: AuthenticateUser::EMAIL, password: 'wrong') }

      it 'has errors' do
        expect(response.errors.size.positive?).to eq(true)
      end

      it 'returns a negative response' do
        expect(response.failure?).to eq(true)
        expect(response.success?).to eq(false)
      end

      it 'runs all defined callbacks' do
        expect(response.after_callback_called).to eq(true)
        expect(response.before_callback_called).to eq(true)
        expect(response.around_callback_called_after_yield).to eq(true)
        expect(response.around_callback_called_before_yield).to eq(true)
      end
    end

    context 'with missing credentials' do
      let(:response) { AuthenticateUser.perform(email: AuthenticateUser::EMAIL) }

      it 'has errors' do
        expect(response.errors.size.positive?).to eq(true)
      end

      it 'returns a negative response' do
        expect(response.failure?).to eq(true)
        expect(response.success?).to eq(false)
      end

      it 'does not call #perform method' do
        expect(response.performed).to eq(false)
      end

      it 'does not run any defined callbacks' do
        expect(response.after_callback_called).to eq(false)
        expect(response.before_callback_called).to eq(false)
        expect(response.around_callback_called_after_yield).to eq(false)
        expect(response.around_callback_called_before_yield).to eq(false)
      end
    end

    it 'does not call #perform method when aborted in a before callback' do
      response = AuthenticateUser.perform(email: AuthenticateUser::EMAIL, password: 'admin')

      expect(response.performed).to eq(false)
      expect(response.after_callback_called).to eq(false)
      expect(response.before_callback_called).to eq(true)
      expect(response.around_callback_called_after_yield).to eq(false)
      expect(response.around_callback_called_before_yield).to eq(false)
    end
  end

  describe '.perform!' do
    context 'with success' do
      let(:response) { AuthenticateUser.perform!(email: AuthenticateUser::EMAIL, password: AuthenticateUser::PASSWORD) }

      it 'does not raise an exception' do
        expect { response }.not_to raise_error
      end
    end

    context 'with failure' do
      let(:response) { AuthenticateUser.perform!(email: AuthenticateUser::EMAIL) }

      it 'raises an exception' do
        expect { response }.to raise_error(ServiceRecord::Failure)
      end
    end
  end
end
