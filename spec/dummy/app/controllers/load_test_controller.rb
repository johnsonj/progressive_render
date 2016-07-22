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
end