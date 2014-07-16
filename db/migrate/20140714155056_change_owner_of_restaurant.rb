class ChangeOwnerOfRestaurant < ActiveRecord::Migration
  def change
  	change_column :restaurants, :owner_id, :string, { null: false, default: 0}
  end
end
