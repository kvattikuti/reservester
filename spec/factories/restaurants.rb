# spec/factories/restaurants.rb 
require 'Faker'

FactoryGirl.define do 
	factory :restaurant do |f| 
		f.name { Faker::Name.name }
		f.description "Description" 
		f.street { Faker::Address.street_address }
		f.city { Faker::Address.city }
		f.state { Faker::Address.state }
		f.zipCode { Faker::Address.zip_code }
		f.phoneNumber { Faker::PhoneNumber.phone_number }
		f.owner# = current_owner

		after(:build) do |restaurant| 
			restaurant.reservations << FactoryGirl.build(:reservation, restaurant: restaurant)
		end

	end 

	factory :valid_restaurant, parent: :restaurant do |f| 

	end 

	factory :invalid_restaurant, parent: :restaurant do |f| 
		f.name nil 
	end 
end