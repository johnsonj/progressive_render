module ProgressiveRender
  module Rails
    class PathResolver
      class TemplateContext
        attr_accessor :controller, :action, :type

        def valid?
          return false if type != :view && type != :controller
          return false if controller.nil? || controller.empty?
          return false if action.nil? || action.empty?
          true
        end
      end

      class InvalidTemplateContextException < RuntimeError
      end

      class InvalidPathException < RuntimeError
      end

      def initialize(_template_context)
        @context = _template_context
      end

      def path_for(view_name = nil)
        raise InvalidTemplateContextException unless @context && @context.valid?
        raise InvalidPathException if (view_name.nil? || view_name.empty?) && view_action?

        path = "#{@context.controller.downcase}/"

        path += if view_name.nil? || view_name.empty?
                  @context.action.to_s
                else
                  view_name.to_s
                end
      end

      private

      def view_action?
        @context.type == :view
      end
    end
  end
end
