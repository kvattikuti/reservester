class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :email
      t.datetime :requested_datetime
      t.string :message

      t.timestamps
    end
  end
end
