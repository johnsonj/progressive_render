require 'progressive_render'

module ProgressiveRender
  module View
    include Helpers

    def progressive_render(fragment_name, &content)
      progressive_render_content(fragment_name, progressive_request.is_main_load?) do
        if progressive_request.is_main_load?
          render partial: 'progressive_render/placeholder'
        elsif progressive_request.should_render_fragment?(fragment_name)
          content.call
        else
          # Another progressive partial on this page but not the one we've been asked to render
          render text: ""
        end
      end
    end

    def progressive_render_content(fragment_name, placeholder=true)
      content_tag(:div, id: "#{fragment_name}_progressive_render", 
            data: {progressive_render_placeholder: placeholder, 
                   progressive_render_path: progressive_request.load_path(fragment_name)}) do
        yield
      end
    end
  end
end