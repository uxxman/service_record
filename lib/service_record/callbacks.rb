module ServiceRecord
  module Callbacks
    extend ActiveSupport::Concern

    included do
      include ActiveSupport::Callbacks

      define_callbacks :perform, skip_after_callbacks_if_terminated: true
    end

    class_methods do
      def before_perform(*filters, &blk)
        set_callback(:perform, :before, *filters, &blk)
      end

      def after_perform(*filters, &blk)
        set_callback(:perform, :after, *filters, &blk)
      end

      def around_perform(*filters, &blk)
        set_callback(:perform, :around, *filters, &blk)
      end
    end
  end
end
