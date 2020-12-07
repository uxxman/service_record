require 'active_model'
require 'service_record/failure'
require 'service_record/callbacks'

module ServiceRecord
  class Base
    include Callbacks
    include ActiveModel::Attributes
    include ActiveModel::Validations
    include ActiveModel::AttributeAssignment

    attr_accessor :result

    def self.perform(args = {})
      new.tap do |service|
        service.attributes = args
        break service unless service.valid?

        service.run_callbacks :perform do
          service.result = service.perform
        end
      end
    end

    def self.perform!(args = {})
      service = perform(args)
      return service if service.success?

      raise Failure, service
    end

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
