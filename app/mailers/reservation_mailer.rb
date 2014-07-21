class ReservationMailer < ActionMailer::Base
  default from: "reservations_notifier@localhost.com"

  def notify_owner_of_reservation(reservation)
  	@restaurant = reservation.restaurant
  	@reservation = reservation

  	mail(to: @restaurant.owner.email,
  		 subject: @restaurant.name + ' | ' + 'New Reservation(s)')
  end
end
