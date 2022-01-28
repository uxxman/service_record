# frozen_string_literal: true

module ServiceRecord
  # Exception to be raised when a service fails
  class Failure < StandardError
    attr_reader :service

    def initialize(service)
      @service = service

      super(@service.errors.full_messages.join(','))
    end
  end
end
