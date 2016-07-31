require 'uri'

module ProgressiveRender
  module Rack
    class RequestHandler
      FRAGMENT_KEY = 'load_partial'.freeze

      def initialize(_request)
        @request = _request
      end

      def is_main_load?
        fragment_name.nil? || fragment_name == ''
      end

      def fragment_name
        @request.GET[FRAGMENT_KEY]
      end

      def should_render_fragment?(_fragment_name)
        !is_main_load? && fragment_name == _fragment_name
      end

      def load_path(fragment_name)
        return nil unless is_main_load?

        # Ensure we get a fresh copy of the request and aren't modifying it
        query = @request.GET.clone
        query[FRAGMENT_KEY] = fragment_name

        URI::HTTP.build(path: @request.path, query: URI.encode_www_form(query)).request_uri
      end
    end
  end
end
