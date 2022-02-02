# frozen_string_literal: true

require_relative 'lib/service_record/version'

Gem::Specification.new do |spec|
  spec.name          = 'service_record'
  spec.version       = ServiceRecord::VERSION
  spec.email         = ['uxman.sherwani@gmail.com']
  spec.authors       = ['Muhammad Usman']

  spec.summary       = 'Service objects for rails'
  spec.description   = 'ActiveRecord lookalike but for business model requirements'
  spec.homepage      = 'https://github.com/uxxman/service_record'
  spec.license       = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri']          = spec.homepage
  spec.metadata['source_code_uri']       = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['changelog_uri']         = 'https://github.com/uxxman/service_record/releases'

  spec.files            = Dir['lib/**/*']
  spec.extra_rdoc_files = Dir['README.md', 'LICENSE.txt']

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activemodel', '>= 6.0'

  spec.add_development_dependency 'appraisal', '~> 2.3'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.1'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop-packaging', '~> 0.5.1'
  spec.add_development_dependency 'rubocop-performance', '~> 1.8', '>= 1.8.1'
  spec.add_development_dependency 'rubocop-rails', '~> 2.8', '>= 2.8.1'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_development_dependency 'rubocop-rspec', '>= 1.44.1', '~> 2.0'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'
end
