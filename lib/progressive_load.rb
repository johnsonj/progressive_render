require "progressive_load/version"
require "progressive_load/controller"
require "progressive_load/view"

module ProgressiveLoad
  if defined?(::Rails) and Gem::Requirement.new('>= 3.1').satisfied_by?(Gem::Version.new ::Rails.version)
    module Rails
      class Engine < ::Rails::Engine
        initializer "progressive_load.assets.precompile" do |app|
          app.config.assets.precompile += %w( progressive_load.gif progressive_load.js.coffee progressive_load.css.scss )
        end

        initializer "progressive_load.install" do
          ActionController::Base.class_eval do
            include ProgressiveLoad::Controller
          end

          ActionView::Base.class_eval do
            include ProgressiveLoad::View
          end
        end
      end
    end
  else
    puts "WARNING: ProgressiveLoad has not been installed due to missing dependencies"
  end
end
