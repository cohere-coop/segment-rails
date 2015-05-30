# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'segment_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "segment_rails"
  spec.version       = SegmentRails::VERSION
  spec.authors       = ["Zee Spencer"]
  spec.email         = ["zee@zeespencer.com"]

  spec.summary       = %q{Preserve your meta-data! Track analytics on the front end!}
  spec.description   = %q{Preserve your meta-data! Track analytics on the front end!}
  spec.homepage      = "https://github.com/zincmade/segment_rails"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 3.1"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
