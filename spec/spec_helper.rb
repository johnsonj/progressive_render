#
# spec_helper: base for testing suite. Should be kept
# as light weight as possible. Use rails_helper for
# specs that require the kitchen sink.
#

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'
