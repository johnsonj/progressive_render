require 'progressive_render/helpers'

module ProgressiveRender
  module Controller
    include Helpers

    def progressive_render(template=nil)
      tc = Rails::PathResolver::TemplateContext.new

      tc.type       = :controller
      tc.controller = request.params["controller"]
      tc.action     = request.params["action"]
      pr = Rails::PathResolver.new(tc)

      if progressive_request.is_main_load?
        render pr.path_for(template)
      else
        content = render_to_string template: pr.path_for(template), layout: false
        stripped = Nokogiri::HTML(content).at_css("div##{progressive_request.fragment_name}_progressive_render")
        render text: stripped
      end
    end
  end
end