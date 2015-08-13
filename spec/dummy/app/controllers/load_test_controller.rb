class LoadTestController < ApplicationController
	def single
		progressive_render 'load_test/single'
	end
end