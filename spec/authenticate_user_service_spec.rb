require 'services/authenticate_user'

RSpec.describe AuthenticateUser do
  it 'has a positive response when performed without errors' do
    response = AuthenticateUser.perform(
      email: AuthenticateUser::EMAIL,
      password: AuthenticateUser::PASSWORD
    )

    expect(response.success?).to eq(true)
    expect(response.failure?).to eq(false)
    expect(response.errors.size.zero?).to eq(true)
  end

  it 'has a negative response when performed with errors' do
    response = AuthenticateUser.perform(
      email: 'wrong',
      password: 'wrong'
    )

    expect(response.success?).to eq(false)
    expect(response.failure?).to eq(true)
    expect(response.errors.size.zero?).to eq(false)
  end
end
