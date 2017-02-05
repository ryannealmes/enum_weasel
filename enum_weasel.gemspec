# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enum_weasel/version'

Gem::Specification.new do |spec|
  spec.name          = "enum_weasel"
  spec.version       = EnumWeasel::VERSION
  spec.authors       = ["Ryan-Neal Mes", "Andrew Tainton"]
  spec.email         = ["ryan.mes@gmail.com", "atainton@gmail.com"]

  spec.summary       = %q{Generates and syncs backing tables for enums on rails 
  models. Primary purpose is to provide semantic meaning to enums for SQL reports.}
  spec.description   = %q{Having your enums in code for performance reasons is 
  great, but if you work with data analytics teams and they write scripts that 
  use these enums, it helps for them to have a means to determine what values are 
  associated to what enum values. This gem generates these tables so they can be 
  joined onto when writing scripts.}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
end
