require_relative 'lib/service_record/version'

Gem::Specification.new do |spec|
  spec.name          = 'service_record'
  spec.version       = ServiceRecord::VERSION
  spec.authors       = ['Muhammad Usman']
  spec.email         = ['uxman.sherwani@gmail.com']

  spec.summary       = 'Service objects for rails'
  spec.description   = 'ActiveRecord lookalike but for business model requirements'
  spec.homepage      = 'https://github.com/uxxman/service_record'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
