require 'nokogiri'

module ProgressiveRender
  module Rails
    class ViewRenderer
      attr_accessor :context
      def initialize(_view_context)
        self.context = _view_context
      end
      def render_partial(path)
        context.render partial: path
      end
      def render_view(path)
        context.render path
      end
      def render_fragment(path, fragment_name)
        content = context.render_to_string template: path, layout: false
        stripped = Nokogiri::HTML(content).at_css("div##{fragment_name}_progressive_render")
        context.render text: stripped.to_html
      end
    end
  end
end