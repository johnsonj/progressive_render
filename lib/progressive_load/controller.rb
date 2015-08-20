require 'progressive_load/helpers'

module ProgressiveLoad
  module Controller
    include Helpers

    def progressive_render(template=nil)
      rh = ProgressiveLoad::Rack::RequestHandler.new(request)

      tc = ProgressiveLoad::Rails::PathResolver::TemplateContext.new

      tc.type       = :controller
      tc.controller = request.params["controller"]
      tc.action     = request.params["action"]
      pr = ProgressiveLoad::Rails::PathResolver.new(tc)

      if rh.is_main_load?
        render pr.path_for(template)
      else
        content = render_to_string template: pr.path_for(template), layout: false
        stripped = Nokogiri::HTML(content).at_css("div##{rh.fragment_name}_progressive_load")
        render text: stripped
      end
    end
  end
end