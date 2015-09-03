class LoadTestController < ApplicationController
	def index
	end

	def block
		progressive_render
	end
end