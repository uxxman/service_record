require 'service_record/callbacks'

module ServiceRecord
  class Base
    include Callbacks
    include ActiveModel::Attributes
    include ActiveModel::Validations
    include ActiveModel::AttributeAssignment
    include ActiveModel::Validations::Callbacks

    def self.perform(args = {})
      new.tap do |service|
        service.attributes = args
        break service unless service.valid?

        service.run_callbacks :perform do
          service.result = service.perform
          service.result = nil if service.failure?
        end
      end
    end

    attr_accessor :result

    def success?
      errors.empty?
    end

    def failure?
      !success?
    end

    def perform
      raise NotImplementedError
    end
  end
end
