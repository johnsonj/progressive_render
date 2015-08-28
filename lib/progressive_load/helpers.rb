module ProgressiveLoad
  module Helpers
    def progressive_load_content(name, placeholder=true)
      content_tag(:div, id: "#{name}_progressive_load", data: {progressive_load_placeholder: placeholder, progressive_load_path: progressive_load_path(request, name)}) do
        yield
      end
    end

    def progressive_load_path(req, fragment_name)
      rh = ProgressiveLoad::Rack::RequestHandler.new(req)
      rh.load_path(fragment_name)
    end
  end
end