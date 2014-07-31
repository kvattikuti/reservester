class CreateJoinTableRestaurantCategory < ActiveRecord::Migration
  def change
    create_join_table :restaurants, :categories do |t|
      # t.index [:restaurant_id, :category_id]
      # t.index [:category_id, :restaurant_id]
    end
  end
end
