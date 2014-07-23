class OwnersController < ApplicationController
	def dashboard
		print "dashboard action called"
	end 

	before_action :authenticate_owner!, only: [:dashboard]
end
