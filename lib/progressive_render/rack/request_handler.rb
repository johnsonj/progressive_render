require 'uri'

module ProgressiveRender
  module Rack
    # Wraps a given rack request to determine what sort of request we're dealing with
    # and what specific fragment the request is for when it's a progressive request.
    class RequestHandler
      FRAGMENT_KEY = 'load_partial'.freeze

      def initialize(request)
        @request = request
      end

      def main_load?
        fragment_name.nil? || fragment_name == ''
      end

      def fragment_name
        @request.GET[FRAGMENT_KEY]
      end

      def should_render_fragment?(user_fragment_name)
        !main_load? && fragment_name == user_fragment_name
      end

      def load_path(fragment_name)
        return nil unless main_load?

        # Ensure we get a fresh copy of the request and aren't modifying it
        query = @request.GET.clone
        query[FRAGMENT_KEY] = fragment_name

        URI::HTTP.build(path: @request.path, query: URI.encode_www_form(query)).request_uri
      end
    end
  end
end
