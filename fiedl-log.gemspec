# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fiedl/log/version'

Gem::Specification.new do |spec|
  spec.name          = "fiedl-log"
  spec.version       = Fiedl::Log::VERSION
  spec.authors       = ["Sebastian Fiedlschuster"]
  spec.email         = ["rubygems@fiedlschuster.de"]

  spec.summary       = %q{Simple colored output helper for ruby scripts.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/fiedl/fiedl-log"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib", "lib/fiedl/log"]

  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "colored"
end
