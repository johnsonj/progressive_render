require 'progressive_render/rails/helpers'

module ProgressiveRender
  module Rails
    module Controller
      include Helpers

      def progressive_render(template = nil)
        logger.warn "DEPRECATED: calling 'progressive_render' directly in the controller
          is deprecated and will be removed in future versions.
          It is no longer necessary to explicitly call the render method."
        render template
      end

      def resolve_path(template)
        tc = Rails::PathResolver::TemplateContext.new
        tc.type       = :controller
        tc.controller = request.params['controller']
        tc.action     = request.params['action']

        pr = Rails::PathResolver.new(tc)

        pr.path_for(template)
      end

      def render(options = nil, extra_options = {}, &block)
        # Fall back to the ActionView renderer if we're on the main page load
        # OR we are being called from inside our own code (in_progressive_render?)
        if progressive_request.is_main_load? || in_progressive_render?
          super
        else
          in_progressive_render do
            # To preserve legacy behavior pass options through to resolve_path if it's a string
            # ActiveRecord more properly handles the path so use that when possible.
            template = options if options.is_a? String
            progressive_renderer.render_fragment resolve_path(template), progressive_request.fragment_name
          end
        end
      end

      def in_progressive_render?
        @in_progressive_render
      end

      # To prevent the render call from reentrancy we need to remember if we're in our own render path.
      # Our rendering code calls 'render' to access the real view renderer so we need a way to fall back to it.
      def in_progressive_render
        @in_progressive_render = true
        yield
        @in_progressive_render = false
      end
  end
    end
end
