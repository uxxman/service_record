require 'rails/generators/named_base'

module Rails
  module Generators
    class ServiceGenerator < Rails::Generators::NamedBase
      desc 'This generator creates a service file at app/services'

      def self.default_generator_root
        __dir__
      end

      def create_service_file
        template 'service.rb', File.join('app/services', class_path, "#{file_name}.rb")

        in_root do
          if behavior == :invoke && !File.exist?(application_service_file_name)
            template 'application_service.rb', application_service_file_name
          end
        end
      end

      private

      def application_service_file_name
        'app/services/application_service.rb'
      end
    end
  end
end
