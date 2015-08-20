require 'progressive_load'

module ProgressiveLoad
  module View
    include Helpers

    def progressive_render(fragment_name, fragment_path=nil, options={})
      rh = ProgressiveLoad::Rack::RequestHandler.new(request)

      tc = ProgressiveLoad::Rails::PathResolver::TemplateContext.new

      tc.type       = :view
      tc.controller = request.params["controller"]
      tc.action     = request.params["action"]
      pr = ProgressiveLoad::Rails::PathResolver.new(tc)
      #binding.pry
      progressive_load_content(fragment_name, rh.is_main_load?) do
        if rh.is_main_load?
          render partial: 'progressive_load/placeholder'
        elsif rh.fragment_name == fragment_name
          render ({partial: pr.path_for(fragment_path)}).merge(options)
        else
          # Another progressive partial on this page but not the one we've been asked to render
          render text: ""
        end
      end
    end
  end
end