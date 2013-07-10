ENV['RAILS_ENV'] ||= 'test'
require 'active_record'
require 'timecop'
require 'hideable'
require 'setup'

RSpec.configure do |config|
  config.color_enabled = true
  config.order = 'random'
end
