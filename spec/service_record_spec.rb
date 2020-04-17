RSpec.describe ServiceRecord do
  it 'has a version number' do
    expect(ServiceRecord::VERSION).not_to be nil
  end
end
