# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hideable/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'hideable'
  s.version     = Hideable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Joe Corcoran']
  s.email       = ['joecorcoran@gmail.com']
  s.homepage    = 'http://github.com/joecorcoran/hideable'
  s.summary     = "Don't want to destroy your records? Hide them"
  s.description = 'Enables soft-deletion in ActiveRecord by marking records as hidden'

  s.add_development_dependency 'rspec',        '~> 2.14.0'
  s.add_development_dependency 'rake',         '~> 10.1.0'
  s.add_development_dependency 'sqlite3',      '~> 1.3.6'
  s.add_development_dependency 'timecop',      '~> 0.6.1'
  s.add_development_dependency 'appraisal',    '~> 0.5.2'

  s.files        = Dir['{lib}/**/*.rb'] + ['README.md', 'LICENSE.txt']
  s.require_path = 'lib'
end
