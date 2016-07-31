require 'action_controller/railtie'

module MockRailsApp
  class Application < Rails::Application
    config.secret_token = '2442e998905e6cdad842eb483e64641a'
  end

  class ApplicationController < ActionController::Base
  end
end
