require 'progressive_load/rack/request_handler'

FRAGMENT_KEY = ProgressiveLoad::Rack::RequestHandler::FRAGMENT_KEY

describe ProgressiveLoad::Rack::RequestHandler do
	it "can parse the main load" do
		req = double
		allow(req).to receive(:GET).and_return({})
		allow(req).to receive(:path).and_return("/foo")

		rh = ProgressiveLoad::Rack::RequestHandler.new(req)
		expect(rh.is_main_load?).to eq(true)
		expect(rh.fragment_name).to eq(nil)
		expect(rh.load_path('bar')).to eq("/foo?#{FRAGMENT_KEY}=bar")
	end

	it "can parse the name of a partial on progressive load" do
		req = double
		allow(req).to receive(:GET).and_return({"#{FRAGMENT_KEY}" => "my_partial"})
		allow(req).to receive(:path).and_return("/bar/baz")

		rh = ProgressiveLoad::Rack::RequestHandler.new(req)
		expect(rh.is_main_load?).to eq(false)
		expect(rh.fragment_name).to eq("my_partial")
		expect(rh.load_path('bar')).to eq(nil)
	end
end