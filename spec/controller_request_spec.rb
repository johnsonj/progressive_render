require 'rails_helper'

def load_test_endpoint(endpoint, name="Testing #{endpoint}", sections=[], assert_preloaded=[], assert_loaded=[])
	describe name do
		it "renders the placeholder and can resolve the real partial" do
			get endpoint
			expect(response.body).to include("progressive-render-placeholder")

			main_request_doc = Nokogiri::HTML(response.body)
			sections.each_with_index do |s,i|
				# Extract the new request URL
				path = main_request_doc.css("##{s}_progressive_render")[0]["data-progressive-render-path"]
				# Ensure it hasn't loaded the contnet
				expect(main_request_doc.css("##{assert_loaded[i]}")).to be_empty

				get path
				partial_request_doc = Nokogiri::HTML(response.body)
				# Find the result
				replacement = partial_request_doc.css("##{assert_loaded[i]}")[0]
			end
		end
	end
end

RSpec.describe LoadTestController, type: :request do
	load_test_endpoint('/load_test/block', 'With a single block', ['slow_section'], [], ['world'])
	load_test_endpoint('/load_test/multiple_blocks', 'With multiple blocks', ['first', 'second', 'third'], [], ['first', 'second', 'third'])
	load_test_endpoint('/load_test/custom_placeholder', 'With a custom placeholder', ['first'], ['custom_placeholder'], ['first'])
end