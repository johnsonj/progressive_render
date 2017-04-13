require 'progressive_render/rails/helpers'

module ProgressiveRender
  module Rails
    # Provides methods for application view
    module View
      include Helpers

      # Mark a section of content to be loaded after initial view of the page.
      #
      # == Usage
      #  <%= progressive_render do %>
      #    <h2>Content!</h2>
      #  <% end %>
      #
      # == Specify a custom placeholder
      # The progressive_render method puts a simple spinner on the page by default but
      # that can be customized per section by passing a path to a partial via `placeholder`
      #
      #  <%= progressive_render placeholder: 'shared/custom_placehodler' do %>
      #    <h2>More Content!</h2>
      #  <% end %>
      def progressive_render(deprecated_fragment_name = nil,
                             placeholder: 'progressive_render/placeholder')
        if deprecated_fragment_name
          logger.warn %(DEPRECATED (progressive_render): Literal fragment names are deprecated and will be removed
            in v1.0. The fragment name (#{deprecated_fragment_name}) will be ignored.")
        end

        progressive_render_impl(placeholder: placeholder) do
          yield
        end
      end

      private

      def progressive_render_impl(placeholder: 'progressive_render/placeholder')
        fragment_name = fragment_name_iterator.next!

        progressive_render_content(fragment_name, progressive_request.main_load?) do
          if progressive_request.main_load?
            progressive_renderer.render_partial placeholder
          elsif progressive_request.should_render_fragment?(fragment_name)
            yield
          end
        end
      end

      def progressive_render_content(fragment_name, placeholder = true)
        data = { progressive_render_placeholder: placeholder,
                 progressive_render_path: progressive_request.load_path(fragment_name) }.reject { |_k, v| v.nil? }

        content_tag(:div, id: "#{fragment_name}_progressive_render",
                          data: data) do
          yield
        end
      end

      def fragment_name_iterator
        @fni ||= FragmentNameIterator.new
      end
    end
  end
end
