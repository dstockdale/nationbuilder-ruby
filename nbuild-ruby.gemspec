# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nation_builder/version'

Gem::Specification.new do |spec|
  spec.name          = "nbuild-ruby"
  spec.version       = NationBuilder::VERSION
  spec.authors       = ["Daniel Walmsley"]
  spec.email         = ["dan@nationbuilder.com"]
  spec.description   = %q{A Ruby client for the NationBuilder API}
  spec.summary       = %q{A Ruby client for the NationBuilder API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "oauth2", "~> 0.9"
  spec.add_runtime_dependency "activemodel"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "rspec"
end
