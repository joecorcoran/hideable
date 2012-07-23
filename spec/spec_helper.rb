# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
#require File.expand_path("../../config/environment", __FILE__)
#require 'rspec/rails'
#require 'rspec/autorun'
require 'active_record'
require 'timecop'
require 'hideable'
require 'setup'

RSpec.configure do |config|
  config.color_enabled = true
  config.order = "random"
end