require "rails_helper"

RSpec.describe ReservationMailer, :type => :mailer do

	context "send mailer" do
		before :each do 
			@restaurant = FactoryGirl.create(:restaurant)
  			@message = ReservationMailer.notify_owner_of_reservation @restaurant.reservations.first
		end

  		it "contains restaurant name" do
  			expect(@message.body).to include(@restaurant.name)
  		end
  		it "contains reservation email" do
  			expect(@message.body).to include(@restaurant.reservations.first.email)
  		end
  		it "contains reservation datetime" do
  			expect(@message.body).to include(@restaurant.reservations.first.requested_datetime)
  		end
  		it "contains reservation message" do
  			expect(@message.body).to include(@restaurant.reservations.first.message)
  		end
  		it "sent to the owner" do
  			expect(@message.to).to include(@restaurant.owner.email)
  		end
	end
end
