module ProgressiveRender
  module Helpers
    def progressive_render_content(name, placeholder=true)
      content_tag(:div, id: "#{name}_progressive_render", data: {progressive_render_placeholder: placeholder, progressive_render_path: progressive_render_path(request, name)}) do
        yield
      end
    end

    def progressive_render_path(req, fragment_name)
      rh = ProgressiveRender::Rack::RequestHandler.new(req)
      rh.load_path(fragment_name)
    end
  end
end