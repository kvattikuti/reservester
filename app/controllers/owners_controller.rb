class OwnersController < ApplicationController
	def dashboard
		print "dashboard action called"
		@restaurants = current_owner.restaurants
	end 

	before_action :authenticate_owner!, only: [:dashboard]
end
