$:.push File.expand_path('../lib', __FILE__)
require 'dradis/plugins/osvulndb/version'
version = Dradis::Plugins::Osvulndb::VERSION::STRING

Gem::Specification.new do |spec|
  spec.platform    = Gem::Platform::RUBY
  spec.name        = 'dradis-osvulndb'
  spec.version     = version
  spec.summary     = 'VulnDB add-on for the Dradis Framework.'
  spec.description = 'Use a VulnDB repository as source of re-usable issue entries for Dradis Framework.'

  spec.license     = 'GPL-2'

  spec.authors     = ['Mathieu Deous']
  spec.email       = ['mat.deous@gmail.com']
  spec.homepage    = 'https://github.com/mdeous/dradis-osvulndb'

  spec.files       = `git ls-files`.split($\)
  spec.executables = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.test_files  = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_dependency 'dradis-plugins', '~> 4.0.0'
end
