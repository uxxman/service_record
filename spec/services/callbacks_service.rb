# frozen_string_literal: true

class CallbacksService < ServiceRecord::Base
  attribute :param, :string
  validates :param, presence: true, inclusion: { in: %w[valid abort] }

  before_perform do
    throw :abort if param == 'abort'
    add_to_stack :before
  end

  around_perform do |_, block|
    add_to_stack :around_before
    block.call
    add_to_stack :around_after
  end

  after_perform do
    add_to_stack :after
  end

  def perform
    add_to_stack :perform

    @called_stack
  end

  private

  def add_to_stack(callback)
    @called_stack ||= []
    @called_stack << callback
  end
end
