class Reservation < ActiveRecord::Base
	validates_presence_of :email
	validates_presence_of :requested_datetime
	validates_presence_of :restaurant

	belongs_to :restaurant, inverse_of: :reservations

	after_save :notify_owner

	def is_new?
		new_record?
	end

	def notify_owner 
		ReservationMailer.notify_owner_of_reservation(self).deliver
	end

end
