# frozen_string_literal: true

class CallbacksService < ServiceRecord::Base
  attribute :param, :string
  attribute :perform_func_called,           :boolean, default: false
  attribute :after_callback_called,         :boolean, default: false
  attribute :before_callback_called,        :boolean, default: false
  attribute :around_after_callback_called,  :boolean, default: false
  attribute :around_before_callback_called, :boolean, default: false

  validates :param, presence: true, inclusion: { in: %w[valid abort] }

  before_perform do
    self.before_callback_called = true
    throw :abort if param == 'abort'
  end

  around_perform do |_, block|
    self.around_before_callback_called = true

    block.call

    self.around_after_callback_called = true
  end

  after_perform do
    self.after_callback_called = true
  end

  def perform
    self.perform_func_called = true
  end
end
