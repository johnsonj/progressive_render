require 'progressive_render/version'
require 'progressive_render/controller'
require 'progressive_render/view'

require 'progressive_render/rack'
require 'progressive_render/rails'

require 'progressive_render/fragment_name_iterator'

module ProgressiveRender
  if defined?(::Rails) and Gem::Requirement.new('>= 3.1').satisfied_by?(Gem::Version.new ::Rails.version)
    module Rails
      class Engine < ::Rails::Engine
        initializer "progressive_render.assets.precompile" do |app|
          app.config.assets.precompile += %w( progressive_render.gif progressive_render.js.coffee progressive_render.css.scss )
        end

        initializer "progressive_render.install" do
          ActionController::Base.class_eval do
            prepend ProgressiveRender::Controller
          end

          ActionView::Base.class_eval do
            prepend ProgressiveRender::View
          end
        end
      end
    end
  else
    puts "WARNING: ProgressiveRender has not been installed due to missing dependencies"
  end
end
