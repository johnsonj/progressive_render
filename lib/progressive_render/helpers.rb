module ProgressiveRender
  module Helpers
    def progressive_request
      @rh ||= Rack::RequestHandler.new(request)
    end
  end
end