class CategoriesController < ApplicationController
  def index
  	@all_categories = Category.all
  	if params[:category_list]
  		@categories = Category.find(params[:category_list])
  	else
  		@categories = @all_categories
  	end
  end

  def show
  	@category = Category.find(params[:id])
  	@restaurants = @category.restaurants
  end
end
