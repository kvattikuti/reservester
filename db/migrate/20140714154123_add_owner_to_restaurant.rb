class AddOwnerToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :owner_id, :string
  end
end
