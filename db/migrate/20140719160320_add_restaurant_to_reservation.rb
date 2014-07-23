class AddRestaurantToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :restaurant_id, :string
  end
end
