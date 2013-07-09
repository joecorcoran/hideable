# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hideable/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'hideable'
  s.version     = Hideable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Joe Corcoran']
  s.email       = ['joe@tribesports.com']
  s.homepage    = 'http://rubygems.org/gems/hideable'
  s.summary     = "Don't want to destroy your records? Hide them"
  s.description = 'Enables soft-deletion in ActiveRecord by marking records as hidden'

  s.add_development_dependency 'bundler',      '>= 1.0.0.rc.6'
  s.add_development_dependency 'rspec',        '~> 2.11.0'
  s.add_development_dependency 'activerecord', '~> 3.2.6'
  s.add_development_dependency 'rake',         '~> 0.9.2'
  s.add_development_dependency 'sqlite3',      '~> 1.3.6'
  s.add_development_dependency 'timecop',      '~> 0.3.5'
  s.add_development_dependency 'appraisal',    '~> 0.4.1'

  s.files        = Dir['{lib}/**/*.rb'] + ['README.md']
  s.require_path = 'lib'
end
