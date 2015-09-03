require 'progressive_render/helpers'

module ProgressiveRender
  module Controller
    include Helpers

    def progressive_render(template=nil)
      rh = ProgressiveRender::Rack::RequestHandler.new(request)

      tc = ProgressiveRender::Rails::PathResolver::TemplateContext.new

      tc.type       = :controller
      tc.controller = request.params["controller"]
      tc.action     = request.params["action"]
      pr = ProgressiveRender::Rails::PathResolver.new(tc)

      if rh.is_main_load?
        render pr.path_for(template)
      else
        content = render_to_string template: pr.path_for(template), layout: false
        stripped = Nokogiri::HTML(content).at_css("div##{rh.fragment_name}_progressive_render")
        render text: stripped
      end
    end
  end
end