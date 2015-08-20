require 'uri'

module ProgressiveLoad
	module Rack
		class RequestHandler
			FRAGMENT_KEY = "load_partial"

			def initialize(_request)
				@request = _request
			end

			def is_main_load?
				fragment_name == nil
			end

			def fragment_name
				@request.GET[FRAGMENT_KEY]
			end

			def load_path(fragment_name)
				return nil if !is_main_load?

				query = @request.GET
				query[FRAGMENT_KEY] = fragment_name

				URI::HTTP.build(path: @request.path, query: URI.encode_www_form(query)).request_uri
			end
		end
	end
end