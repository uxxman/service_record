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

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri']   = 'https://github.com/uxxman/service_record/releases'

  spec.files            = Dir['lib/**/*']
  spec.extra_rdoc_files = Dir['README.md', 'LICENSE.txt']

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activemodel', '>= 6.0'
end
