require 'rails_helper'

RSpec.describe Reservation, :type => :model do
	it "is valid reservation with email, requested_datetime and restaurant" do
		expect(FactoryGirl.create(:reservation, message:nil)).to be_valid
	end

	it "is valid reservation with email, requested_datetime, message, and restaurant" do
		expect(FactoryGirl.create(:reservation)).to be_valid
	end

	it "is invalid reservation without email" do
		expect(FactoryGirl.build(:reservation, email:nil)).not_to be_valid
	end

	it "is invalid reservation without requested_datetime" do
		expect(FactoryGirl.build(:reservation, requested_datetime:nil)).not_to be_valid
	end

	it "is invalid reservation without restaurant" do
		expect(FactoryGirl.build(:reservation, restaurant:nil)).not_to be_valid
	end
end
