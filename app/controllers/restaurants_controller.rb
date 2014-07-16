class RestaurantsController < ApplicationController

	def new
	end

	def index
  		@restaurants = Restaurant.all
	end

	def create
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
	  	@restaurant = Restaurant.find(params[:id])
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		if current_owner.owns?(@restaurant)
			if @restaurant.update(restaurant_params)
				redirect_to @restaurant
			else
				render 'edit'
			end
		else
			@restaurant.errors[:base] << "You should be the owner of the restaurant to edit"
			render 'edit'
		end
	end

	def destroy
		@restaurant = Restaurant.find(params[:id])
		@restaurant.destroy

		redirect_to restaurants_path
	end

	before_action :authenticate_owner!, only: [:create, :update, :destroy, :edit]

	private

		def restaurant_params
			params.require(:restaurant).permit(:name, :description, :street, :city, :state, :zipCode, :phoneNumber, :picture, :picture_url, :picture_cache)
		end
end
