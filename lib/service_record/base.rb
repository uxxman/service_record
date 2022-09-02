# frozen_string_literal: true

require 'active_model'
require 'service_record/failure'
require 'service_record/response'
require 'service_record/callbacks'

module ServiceRecord
  # Base class to be extended by all service classes
  #
  # class MyService < ServiceRecord
  # end
  #
  class Base
    include Callbacks
    include ActiveModel::Attributes
    include ActiveModel::Validations
    include ActiveModel::AttributeAssignment

    attr_accessor :result

    # Wrapper around the *perform* instance method that runs all the validations
    # and callbacks before eventually calling *perform*.
    def self.perform(args = {})
      new.tap do |service|
        service.attributes = args

        if service.valid?
          service.run_callbacks :perform do
            service.result = service.perform
          end
        end

        return Response.new(service.result, service.errors)
      end
    end

    # Wapper around the *perform* class method that raises exception if service fails
    def self.perform!(args = {})
      service = perform(args)
      return service if service.success?

      raise Failure, service
    end

    # Each subclass must define the *perform* method
    def perform
      raise NotImplementedError
    end
  end
end
