require 'progressive_render/helpers'

module ProgressiveRender
  module Controller
    include Helpers

    def progressive_render(template=nil)
      if progressive_request.is_main_load?
        render resolve_path(template)
      else
        content = render_to_string template: resolve_path(template), layout: false
        stripped = Nokogiri::HTML(content).at_css("div##{progressive_request.fragment_name}_progressive_render")
        render text: stripped
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