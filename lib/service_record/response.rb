# frozen_string_literal: true

module ServiceRecord
  # Response to be returned by a service when it finishes
  class Response
    attr_reader :result, :errors

    def initialize(result, errors)
      @result = result
      @errors = errors
    end

    # Checks for errors. Returns +true+ if no errors are found, +false+ otherwise.
    def success?
      errors.empty?
    end

    # Checks for errors. Returns +false+ if no errors are found, +true+ otherwise.
    def failure?
      !success?
    end
  end
end
