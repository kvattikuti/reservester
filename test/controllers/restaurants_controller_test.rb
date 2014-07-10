require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should show all restaurants on root or index action" do
  	get :index
  	assert_response :success
  	assert_not_nil assigns(:restaurants)
  end

  test "should successfully create a new restaurant" do
  	print restaurants(:one).name
  	post(:create, {:name => "#{restaurants(:one).name}"})
  	assert_response :success
  	assert_not_nil assigns(:restaurant)
  end

end
