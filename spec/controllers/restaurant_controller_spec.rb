require 'rails_helper'

describe RestaurantsController do
	describe "GET #index" do

		it "populates restaurant list" do
			restaurant = FactoryGirl.create(:restaurant)
			get :index
			expect(assigns(:restaurants)).to eq([restaurant])
		end

		it "renders the :index view" do
			get :index 
			expect(response).to render_template :index 
		end
	end

	describe "GET #show" do

		it "should receive find" do
			restaurant = FactoryGirl.create(:restaurant)
			Restaurant.should_receive(:find).with(restaurant.id.to_s).and_return(restaurant)
			get :show, id: restaurant
		end

		it "should receive find2" do
			Restaurant.should_receive(:find).with("1")
			get :show, id: "1"
		end

		it "assigns the requested restaurant to @restaurant" do
			restaurant = FactoryGirl.create(:restaurant)
			get :show, id: restaurant
			expect(assigns(:restaurant)).to eq(restaurant)
		end

		it "renders the #show view" do
			get :show, id: FactoryGirl.create(:restaurant)
			expect(response).to render_template :show
		end

		it "defaults to index page when no restaurant is found" do
			expect { get :show, id: "-1" }.to raise_error ActiveRecord::RecordNotFound
		end
	end

	describe "POST #create" do
		context "valid attributes" do
			it "creates valid restaurant successfully" do
				expect { 
					post :create, restaurant: FactoryGirl.attributes_for(:restaurant) 
				}.to change(Restaurant,:count).by(1)  
			end

			it "redirects to the new restaurant" do 
				post :create, restaurant: FactoryGirl.attributes_for(:restaurant) 
				expect(response).to redirect_to Restaurant.last
			end
		end

		context "invalid attributes" do
			it "does not create invalid restaurant" do
				expect { 
					post :create, restaurant: FactoryGirl.attributes_for(:invalid_restaurant) 
				}.to_not change(Restaurant,:count)
			end

			it "renders :new view upon failing to create invalid restaurant" do 
				post :create, restaurant: FactoryGirl.attributes_for(:invalid_restaurant) 
				expect(response).to render_template :new
			end
		end
	end

	describe "GET #edit" do 
		it "renders editable form for valid restaurant" do
			restaurant = FactoryGirl.create(:restaurant)
			get :edit, id: restaurant
			expect(response).to render_template :edit
		end
	end

	describe "PUT #update" do

		before :each do 
			@restaurant = FactoryGirl.create(:restaurant, description: "New Description") 
		end 

		context "valid attributes" do
			it "located the requested @restaurant" do
				put :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:restaurant) 
				expect(assigns(:restaurant)).to eq(@restaurant)
			end

			it "updates are reflected in the database" do
				put :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:restaurant, description: "New Description2")
				@restaurant.reload
				expect(@restaurant.description).to eq("New Description2")
			end

			it "redirects to updated restaurant" do 
				put :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:restaurant)
				expect(response).to redirect_to @restaurant
			end
		end

		context "invalid attributes" do
			it "loads restaurant for update" do
				put :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:invalid_restaurant) 
				expect(assigns(:restaurant)).to eq(@restaurant)
			end

			it "does not update restaurant because of invalid attributes" do
				put :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:invalid_restaurant) 
				@restaurant.reload
				expect(@restaurant.description).to eq("New Description")
			end

			it "renders :edit view upon failing to update invalid restaurant" do 
				put :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:invalid_restaurant) 
				expect(response).to render_template :edit
			end
		end
	end

end