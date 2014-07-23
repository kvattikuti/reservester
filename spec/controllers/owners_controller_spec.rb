require 'rails_helper'

RSpec.describe OwnersController, :type => :controller do
	it "prevents access to dashboard when owner is not signed in" do
		get 'dashboard'
		expect(response.body).to redirect_to new_owner_session_path
	end

	it "allows access to dashboard when owner is signed in" do
		@owner = FactoryGirl.create(:owner)
		sign_in @owner
		get 'dashboard'
		expect(response).to render_template :dashboard 
	end
end
