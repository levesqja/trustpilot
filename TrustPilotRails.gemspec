# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'TrustPilotRails/version'

Gem::Specification.new do |spec|
  spec.name          = "TrustPilotRails"
  spec.version       = TrustPilotRails::VERSION
  spec.authors       = ["Jalbert Levesque"]
  spec.email         = ["jalb@jalb.net"]
  spec.summary       = %q{TrustPilot API connector.}
  spec.description   = %q{TrustPilot API connector.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "faraday", "~> 0.9.2"
    
end
