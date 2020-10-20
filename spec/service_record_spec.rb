RSpec.describe ServiceRecord do
  it 'has a version number' do
    expect(ServiceRecord::VERSION).not_to be nil
  end

  it 'raises an error when a child class does not implement #perform method' do
    class Service < ServiceRecord::Base; end

    expect { Service.perform }.to raise_error(NotImplementedError)
  end
end
