class LoadTestController < ApplicationController
	def index
	end

	def partial
		progressive_render
	end
end