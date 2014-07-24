class RestaurantsController < ApplicationController

	def new
		@categories = Category.all
		@restaurant = Restaurant.new
	end

	def index
  		@restaurants = Restaurant.all
	end

	def create
		print params
		@restaurant = Restaurant.new(restaurant_params)
		@restaurant.owner = current_owner
		if @restaurant.save
			redirect_to @restaurant
		else
			render 'new'
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def edit
		@categories = Category.all
	  	@restaurant = Restaurant.find(params[:id])
	  	@restaurant.reservations.build
	  	@restaurant
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		#puts "\n\ncurrent_owner is  " + current_owner.name + "\n"
		#puts "restaurant owner is " + @restaurant.owner.name + "\n"
		#print restaurant_params
		update_params = current_owner && current_owner.owns?(@restaurant) ? restaurant_params : restaurant_params_anonymous_user
		if @restaurant.update(update_params)
			redirect_to @restaurant
		else
			render 'edit'
		end
		#else
			#print "You should be the owner of the restaurant to edit" + "\n"
		#	@restaurant.errors[:base] << "You should be the owner of the restaurant to edit"
		#	render 'edit'
		#end
	end

	def destroy
		#puts "\n\nparams are  " + params.to_s
		#puts "request params are " + restaurant_params.to_s + "\n"

		@restaurant = Restaurant.find(params[:id])
		@restaurant.destroy

		redirect_to restaurants_path
	end

	before_action :authenticate_owner!, only: [:create, :destroy]

	private

		def restaurant_params
			params.require(:restaurant).permit(:name, :description, :street, :city, :state, :zipCode, :phoneNumber, 
				:picture, :picture_url, :picture_cache, 
				reservations_attributes: [:id, :_destroy, :email, :requested_datetime, :message], 
				category_list: [])
		end

		def restaurant_params_anonymous_user
			params.require(:restaurant).permit(
				reservations_attributes: [:id, :_destroy, :email, :requested_datetime, :message])
		end
end
