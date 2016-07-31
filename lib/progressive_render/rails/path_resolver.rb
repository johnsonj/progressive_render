module ProgressiveRender
  module Rails
    class PathResolver
      class TemplateContext
        attr_accessor :controller, :action, :type

        def valid?
          valid_type? && valid_controller? && valid_action?
        end
      end

      class InvalidTemplateContextException < RuntimeError
      end

      class InvalidPathException < RuntimeError
      end

      def initialize(template_context)
        @context = template_context
      end

      def path_for(view_name = nil)
        raise InvalidTemplateContextException unless @context && @context.valid?
        raise InvalidPathException if (view_name.nil? || view_name.empty?) && view_action?

        "#{@context.controller.downcase}/#{path_suffix_for(view_name)}"
      end

      private

      def path_suffix_for(view_name)
        if view_name.nil? || view_name.empty?
          @context.action.to_s
        else
          view_name.to_s
        end
      end

      def view_action?
        @context.type == :view
      end

      def valid_type?
        type == :view || type == :controller
      end

      def valid_controller?
        !controller.nil? && !controller.empty?
      end

      def valid_action?
        !action.nil? && !action.empty?
      end
    end
  end
end
