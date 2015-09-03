require 'progressive_render/rack/request_handler'

FRAGMENT_KEY = ProgressiveRender::Rack::RequestHandler::FRAGMENT_KEY

describe ProgressiveRender::Rack::RequestHandler do
	it "can parse the main load" do
		req = double
		allow(req).to receive(:GET).and_return({})
		allow(req).to receive(:path).and_return("/foo")

		rh = ProgressiveRender::Rack::RequestHandler.new(req)
		expect(rh.is_main_load?).to eq(true)
		expect(rh.should_render_fragment?('foo')).to eq(false)
		expect(rh.fragment_name).to eq(nil)
		expect(rh.load_path('bar')).to eq("/foo?#{FRAGMENT_KEY}=bar")
	end

	it "can parse the name of a partial on progressive load" do
		req = double
		allow(req).to receive(:GET).and_return({"#{FRAGMENT_KEY}" => "my_partial"})
		allow(req).to receive(:path).and_return("/bar/baz")

		rh = ProgressiveRender::Rack::RequestHandler.new(req)
		expect(rh.is_main_load?).to eq(false)
		expect(rh.fragment_name).to eq("my_partial")
		expect(rh.should_render_fragment?('foo')).to eq(false)
		expect(rh.should_render_fragment?('my_partial')).to eq(true)
		expect(rh.load_path('bar')).to eq(nil)
	end

	it "does not modify the request object" do
		get_request = {}
		get_clone = get_request.clone
		req = double
		allow(req).to receive(:GET).and_return(get_request)
		allow(req).to receive(:path).and_return("/bar/baz")

		rh = ProgressiveRender::Rack::RequestHandler.new(req)
		rh.load_path('bar')

		expect(get_request[FRAGMENT_KEY]).to be_nil
		expect(get_request).to eq(get_request)
	end
end