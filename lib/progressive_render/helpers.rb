module ProgressiveRender
  module Helpers
    def progressive_request
      @rh ||= Rack::RequestHandler.new(request)
    end
    def progressive_renderer
      Rails::ViewRenderer.new(self)
    end
  end
end