module ServiceRecord
  class Base
    include ActiveModel::Attributes
    include ActiveModel::Validations
    include ActiveModel::AttributeAssignment
    include ActiveModel::Validations::Callbacks

    def self.perform(args = {})
      new.tap do |service|
        service.attributes = args

        if service.valid?
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
