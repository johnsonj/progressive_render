require 'spec_helper'

# Load rails and the entire gem
require 'rails/all'
require 'rspec/rails'
require 'progressive_render'

# Debugging doesn't have to be hard
require 'pry-byebug'

# Set the application into the test enviornment
ENV["RAILS_ENV"] = "test"

# Load the dummy rails app
require File.expand_path("../dummy/config/environment", __FILE__)