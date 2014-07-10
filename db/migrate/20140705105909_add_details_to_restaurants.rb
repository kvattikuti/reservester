class AddDetailsToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :street, :string
    add_column :restaurants, :city, :string
    add_column :restaurants, :state, :string
    add_column :restaurants, :zipCode, :string
  end
end
