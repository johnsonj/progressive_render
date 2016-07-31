module ProgressiveRender
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
end