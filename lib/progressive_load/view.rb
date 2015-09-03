require 'progressive_load'

module ProgressiveLoad
  module View
    include Helpers

    def progressive_render(fragment_name, &content)
      rh = ProgressiveLoad::Rack::RequestHandler.new(request)

      progressive_load_content(fragment_name, rh.is_main_load?) do
        if rh.is_main_load?
          render partial: 'progressive_load/placeholder'
        elsif rh.should_render_fragment?(fragment_name)
          content.call
        else
          # Another progressive partial on this page but not the one we've been asked to render
          render text: ""
        end
      end
    end
  end
end