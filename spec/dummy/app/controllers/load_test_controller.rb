class LoadTestController < ApplicationController
  def example
  end

  def index
  end

  def block
  end

  def multiple_blocks
  end

  def custom_placeholder
  end

  def render_params
    render layout: 'custom_layout'
  end

  def deprecated_explicit_call
    progressive_render
  end

  def deprecated_explicit_call_with_template
    progressive_render 'block'
  end

  def atom_repro
    respond_to do |format|
      # https://github.com/johnsonj/progressive_render/issues/19#issuecomment-236450508
      # Without this format.js call, rails tries to render the 'atom' format on the progressive_load
      format.js do
      end
      format.atom do
        raise 'atom'
      end
      format.html do
        render layout: 'custom_layout'
      end
      format.rss do
        raise 'RSS'
      end
    end
  end
end
