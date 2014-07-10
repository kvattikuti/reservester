class AddPhoneToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :phoneNumber, :string
  end
end
