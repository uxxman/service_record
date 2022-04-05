# frozen_string_literal: true

RSpec.describe ServiceRecord do
  it 'has a version number' do
    expect(ServiceRecord::VERSION).not_to be_nil
  end

  it 'raises an error when a child class does not implement #perform method' do
    stub_const('DummyService', Class.new(ServiceRecord::Base))

    expect { DummyService.perform }.to raise_error(NotImplementedError)
  end
end
