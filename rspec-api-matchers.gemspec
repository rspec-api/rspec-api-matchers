lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec-api/matchers/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-api-matchers"
  spec.version       = RSpecApi::Matchers::VERSION
  spec.authors       = ["claudiob"]
  spec.email         = ["claudiob@gmail.com"]
  spec.description   = %q{RSpec matchers useful to test web APIs.}
  spec.summary       = %q{Methods extracted from rspec-api to chech validity
    of the response of pragmatic RESTful web APIs.}
  spec.homepage      = 'https://github.com/rspec-api/rspec-api-matchers'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib}/**/*'] + ['MIT-LICENSE', 'README.md']

  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'
  spec.required_rubygems_version = ">= 1.3.6"

  spec.add_dependency 'rspec'
  spec.add_dependency 'rack' # for ::Utils
  spec.add_dependency 'activesupport' # for Array.wrap, concern, ...

  # For development / Code coverage / Documentation
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'coveralls'
end