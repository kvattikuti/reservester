class Reservation < ActiveRecord::Base
	validates_presence_of :email
	validates_presence_of :requested_datetime
	validates_presence_of :restaurant

	belongs_to :restaurant, inverse_of: :reservations

	def is_new?
		new_record?
	end

end
