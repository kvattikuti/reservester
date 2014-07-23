# Read about factories at https://github.com/thoughtbot/factory_girl
require 'Faker'

FactoryGirl.define do
  factory :reservation do
    email { Faker::Internet.email }
    requested_datetime { Time.now.to_datetime }
    message { Faker::Lorem.sentence }

    restaurant
  end

  factory :invalid_reservation, parent: :reservation do |f|
  	f.email nil
  end 
end
