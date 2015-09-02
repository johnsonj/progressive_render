require 'rails_helper'

def load_test_endpoint(endpoint, name="Testing #{endpoint}")
	describe name do
		it "renders the placeholder and can resolve the real partial" do
			get endpoint
			expect(response.body).to include("progressive-load-placeholder")

			# Extract the new request URL
			doc = Nokogiri::HTML(response.body)
			path = doc.css('#slow_section_progressive_load')[0]["data-progressive-load-path"]
			# Ensure it hasn't loaded the contnet
			expect(doc.css('#world')).to be_empty

			get path
			doc = Nokogiri::HTML(response.body)
			# Find the result
			replacement = doc.css('#world')[0]
		end
	end
end

RSpec.describe LoadTestController, type: :request do
	load_test_endpoint('/load_test/partial', 'With a single partial')
	load_test_endpoint('/load_test/block', 'With a single block')
end