class LoadTestController < ApplicationController
	def example
		# ...
		progressive_render
	end


	def index
	end

	def block
		progressive_render
	end

	def multiple_blocks
		progressive_render
	end

	def custom_placeholder
		progressive_render
	end
end