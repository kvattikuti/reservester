require 'rails_helper'

describe Restaurant do

	it "has a valid factory" do
		expect(FactoryGirl.create(:restaurant)).to be_valid
	end

	it "is invalid without name" do
		expect(FactoryGirl.build(:valid_restaurant, name: nil)).to_not be_valid
	end

	it "is invalid without description" do
		expect(FactoryGirl.build(:restaurant, description: nil)).to_not be_valid
	end
	
end
