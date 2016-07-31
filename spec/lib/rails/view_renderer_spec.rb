require 'spec_helper'
require 'progressive_render/rails/view_renderer'

describe ProgressiveRender::Rails::ViewRenderer do
  specify '#render_partial' do
    context = double
    allow(context).to receive(:render).and_return(true)

    vr = ProgressiveRender::Rails::ViewRenderer.new(context)
    expect(vr.render_partial('')).to eq(true)
  end

  specify '#render_view' do
    context = double
    allow(context).to receive(:render).and_return(true)

    vr = ProgressiveRender::Rails::ViewRenderer.new(context)
    expect(vr.render_view('')).to eq(true)
  end

  specify '#render_fragment' do
    context = double
    body = '<div id="example_progressive_render">Hello World</div>'
    allow(context).to receive(:render_to_string).and_return("<html><body><h1>Hey Now</h1>#{body}</body></html>")
    allow(context).to receive(:render)

    vr = ProgressiveRender::Rails::ViewRenderer.new(context)
    vr.render_fragment('', 'example')

    expect(context).to have_received(:render).with(plain: body)
  end
end
