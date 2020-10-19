module ServiceRecord
  class Failure < StandardError
    attr_reader :service

    def initialize(service)
      @service = service

      super(@service.errors.full_messages.join(','))
    end
  end
end
