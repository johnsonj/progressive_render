require 'progressive_load/helpers'

module ProgressiveLoad
  module Controller
    include Helpers

    # TODO: We need to specify the full path to the template
    def progressive_render(template)
      if is_main_load?
        render template
      else
        content = render_to_string template: template, layout: false
        stripped = Nokogiri::HTML(content).at_css("div##{params[:load_partial]}_progressive_load")
        render text: stripped
      end
    end
  end
end