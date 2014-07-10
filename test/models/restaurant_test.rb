require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save empty object" do
  	assert_not Restaurant.new.save, "Saved without attributes being set"
  end
end
