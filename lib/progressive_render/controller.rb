require 'progressive_render/helpers'

module ProgressiveRender
  module Controller
    include Helpers

    def progressive_render(template=nil)
      if progressive_request.is_main_load?
        progressive_renderer.render_view resolve_path(template)
      else
        progressive_renderer.render_fragment resolve_path(template), progressive_request.fragment_name 
      end
    end

    def resolve_path(template)
      tc = Rails::PathResolver::TemplateContext.new
      tc.type       = :controller
      tc.controller = request.params["controller"]
      tc.action     = request.params["action"]

      pr = Rails::PathResolver.new(tc)

      pr.path_for(template)
    end
  end
end