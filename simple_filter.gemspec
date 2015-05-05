# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_filter/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_filter"
  spec.version       = SimpleFilter::VERSION
  spec.authors       = ["Matias Leidemer"]
  spec.email         = ["matiasleidemer@gmail.com"]

  spec.summary       = %q{A simple DSL to create filter classes for ActiveRecord scopes}
  spec.description   = %q{A simple DSL to create filter classes for ActiveRecord scopes}
  spec.homepage      = "https://github.com/matiasleidemer/simple_filter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
end
