module ProgressiveLoad
  module Helpers
    def progressive_load_content(name, placeholder=true)
      content_tag(:div, id: "#{name}_progressive_load", data: {progressive_load_placeholder: placeholder, progressive_load_path: progressive_load_path(request, name)}) do
        yield
      end
    end

    def progressive_load_path(req, name)
      # Append the param to the URL. Nasty I know.
      req.fullpath + "#{req.fullpath.include?('?') ? '&' : '?'}load_partial=#{name}" 
    end

    def is_main_load?
      !is_progressive_load?
    end

    def is_progressive_load?
      params[:load_partial]
    end

    def is_loading_this_partial?(name)
      params[:load_partial] == name
    end
  end
end