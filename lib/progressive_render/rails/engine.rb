module ProgressiveRender
  module Rails
    # Rails uses this class to install progressive_render into an application
    # It is responsible for any setup needed for the gem to function
    class Engine < ::Rails::Engine
      initializer 'progressive_render.assets.precompile' do |app|
        app.config.assets.precompile += %w[progressive_render.gif
                                           progressive_render.js.coffee
                                           progressive_render.css.scss]
      end

      initializer 'progressive_render.install' do
        ActionController::Base.class_eval do
          prepend ProgressiveRender::Rails::Controller
        end

        ActionView::Base.class_eval do
          prepend ProgressiveRender::Rails::View
        end
      end
    end
  end
end
