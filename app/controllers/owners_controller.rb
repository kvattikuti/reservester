class OwnersController < ApplicationController
	def dashboard
		@restaurants = current_owner.restaurants
	end 

	before_action :authenticate_owner!, only: [:dashboard]
end
