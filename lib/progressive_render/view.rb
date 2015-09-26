require 'progressive_render'

module ProgressiveRender
  module View
    include Helpers

    def progressive_render(fragment_name, placeholder: 'progressive_render/placeholder', &content)
      progressive_render_content(fragment_name, progressive_request.is_main_load?) do
        if progressive_request.is_main_load?
          progressive_renderer.render_partial placeholder
        elsif progressive_request.should_render_fragment?(fragment_name)
          content.call
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