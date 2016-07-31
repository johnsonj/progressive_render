require 'rails_helper'

def load_test_endpoint(endpoint, name: "Testing #{endpoint}", sections: [], assert_preloaded: nil, assert_loaded: nil)
  describe name do
    it 'renders the placeholder and can resolve the real partial' do
      get endpoint
      expect(response.body).to include('progressive-render-placeholder')

      main_request_doc = Nokogiri::HTML(response.body)
      sections.each_with_index do |s, i|
        section_placeholder_selector = "##{s}_progressive_render"
        section_content_selector     = assert_loaded[i] if assert_loaded
        section_preloaded_selector   = assert_preloaded[i] if assert_preloaded

        # Extract the new request URL
        path = main_request_doc.css(section_placeholder_selector)[0]['data-progressive-render-path']
        # It hasn't loaded the content
        expect(main_request_doc.css(section_content_selector)).to be_empty
        # The preloaded content is in the main response
        expect(main_request_doc.css(section_preloaded_selector)).to_not be_empty if section_preloaded_selector

        get path
        partial_request_doc = Nokogiri::HTML(response.body)
        # Find the result
        replacement = partial_request_doc.css(section_content_selector)[0]
        expect(replacement).to_not be nil

        # The placeholder is not in the partial request
        expect(partial_request_doc.css(section_placeholder_selector)[0]['data-progressive-render-placeholder']).to eql('false')
        expect(partial_request_doc.css(section_placeholder_selector)[0]['data-progressive-render-path']).to be_nil
        # The preloaded content is not in the partial request
        expect(partial_request_doc.css(section_preloaded_selector)).to be_empty if section_preloaded_selector
      end
    end
  end
end

RSpec.describe LoadTestController, type: :request do
  # Basic examples
  load_test_endpoint '/load_test/block', name: 'With a single block', sections: [1], assert_loaded: ['#world']
  load_test_endpoint '/load_test/multiple_blocks',    name: 'With multiple blocks',      sections: [1, 2, 3], assert_loaded: ['#first', '#second', '#third']
  load_test_endpoint '/load_test/custom_placeholder', name: 'With a custom placeholder', sections: [1],     assert_preloaded: ['#custom_placeholder'], assert_loaded: ['#first']
  load_test_endpoint '/load_test/render_params',      name: 'With custom render params', sections: [1],     assert_preloaded: ['#custom_layout'],      assert_loaded: ['#world']

  # Deprecated usage
  load_test_endpoint '/load_test/deprecated_explicit_call',               name: 'Deprecated: Explicit call in controller',                    sections: [1],     assert_loaded: ['#world']
  load_test_endpoint '/load_test/deprecated_explicit_call_with_template', name: 'Deprecated: Explicit call in controller with template path', sections: [1],     assert_loaded: ['#world']

  # Specific bugs
  load_test_endpoint '/load_test/atom_repro', name: 'With an atom format', sections: [1], assert_preloaded: ['#outside'], assert_loaded: ['#inside']
end
