# frozen_string_literal: true

module ServiceRecord
  # Defines before/around/after callbacks for the 'perform' method
  module Callbacks
    extend ActiveSupport::Concern

    included do
      include ActiveSupport::Callbacks

      define_callbacks :perform, skip_after_callbacks_if_terminated: true
    end

    class_methods do
      def before_perform(...)
        set_callback(:perform, :before, ...)
      end

      def after_perform(...)
        set_callback(:perform, :after, ...)
      end

      def around_perform(...)
        set_callback(:perform, :around, ...)
      end
    end
  end
end
