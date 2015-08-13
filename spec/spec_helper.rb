require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'
require 'rails/all'   # This could be lightened up I bet
require 'rspec/rails'
require 'progressive_load'
