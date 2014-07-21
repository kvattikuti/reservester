require 'rails_helper'

describe RestaurantsController do

	describe "Factory" do
		it "is created with current owner and one reservation with factory" do
			owner = FactoryGirl.create(:owner)
			sign_in owner
			restaurant = FactoryGirl.create(:restaurant, owner: controller.current_owner)
			expect(restaurant.owner).to eq(owner)
			expect(restaurant.reservations.count).to eq(1)
		end
	end

	describe "GET #index" do
		before do
			owner = FactoryGirl.create(:owner)
			sign_in owner
			@restaurant = FactoryGirl.create(:restaurant, owner: controller.current_owner)
			get :index
		end

		it "populates restaurant list" do
			expect(assigns(:restaurants)).to eq([@restaurant])
		end

		it "renders the :index view" do
			expect(response).to render_template :index 
		end
	end

	describe "GET #show" do

		context "mocking examples compliant with rspec <= 2.99" do
			it "should receive find" do
				restaurant = FactoryGirl.create(:restaurant)
				Restaurant.should_receive(:find).with(restaurant.id.to_s).and_return(restaurant)
				get :show, id: restaurant
			end

			it "should receive find when get is invoked - another way" do
				Restaurant.should_receive(:find).with("1")
				get :show, id: "1"
			end
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
		context "valid restaurant attributes" do
			before :each do
				@owner = FactoryGirl.create(:owner)
				sign_in @owner
			end

			context "without reservations attributes" do
				it "creates valid restaurant successfully" do
					expect { 
						post :create, restaurant: FactoryGirl.attributes_for(:restaurant) 
					}.to change(Restaurant,:count).by(1)  
				end

				it "creates valid restaurant successfully with current owner" do
					post :create, restaurant: FactoryGirl.attributes_for(:restaurant) 
					expect(Restaurant.first.owner.name).to eq(@owner.name) 
				end

				it "redirects to the new restaurant" do 
					post :create, restaurant: FactoryGirl.attributes_for(:restaurant) 
					expect(response).to redirect_to Restaurant.last
				end
			end

			context "with reservations attributes" do
				before :each do
					reservation = FactoryGirl.attributes_for(:reservation)
					#puts "Reservation is " + reservation.to_s
					#puts FactoryGirl.attributes_for(:restaurant, reservations_attributes: [reservation]) 
					post :create, restaurant: FactoryGirl.attributes_for(:restaurant, reservations_attributes: [reservation])
				end

				it "creates valid restaurant successfully with a reservation" do
					puts "First restaurant is " + Restaurant.first.to_s + "\n"
					expect(Restaurant.first.reservations.count).to eq(1)
				end
			end

			context "with invalid reservation attributes" do
				before :each do
					reservation = FactoryGirl.attributes_for(:invalid_reservation)
					post :create, restaurant: FactoryGirl.attributes_for(:restaurant, reservations_attributes: [reservation])
				end

				it "does not create restaurant with invalid reservation" do
					expect(Restaurant.all.count).to eq(0)
				end
			end
		end

		context "invalid restaurant attributes" do
			it "does not create valid restaurant without owner sign in" do
				expect { 
					post :create, restaurant: FactoryGirl.attributes_for(:restaurant) 
				}.to_not change(Restaurant,:count)
			end

			it "does not create invalid restaurant" do
				expect { 
					post :create, restaurant: FactoryGirl.attributes_for(:invalid_restaurant) 
				}.to_not change(Restaurant,:count)
			end

			it "renders :new view upon failing to create invalid restaurant" do 
				owner = FactoryGirl.create(:owner)
				sign_in owner
				post :create, restaurant: FactoryGirl.attributes_for(:invalid_restaurant) 
				expect(response).to render_template :new
			end
		end
	end

	describe "GET #edit" do 
		it "renders editable form for valid restaurant" do
			owner = FactoryGirl.create(:owner)
			sign_in owner
			restaurant = FactoryGirl.create(:restaurant)
			get :edit, id: restaurant
			expect(response).to render_template :edit
		end
	end

	describe "PATCH #update" do

		before :each do
	    	owner = FactoryGirl.create(:owner)
	    	sign_in owner
			@restaurant = FactoryGirl.create(:restaurant, owner: controller.current_owner)
	  	end

		context "valid restaurant attributes" do
			it "located the requested restaurant" do
				#puts "created restaurant is " + @restaurant.name + " id: " + @restaurant.id.to_s + " with owner " + @restaurant.owner.name
				patch :update, id: @restaurant.id, restaurant: FactoryGirl.attributes_for(:restaurant) 
				expect(assigns(:restaurant)).to eq(@restaurant)
			end

			it "updates are reflected in the database" do
				patch :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:restaurant, description: "New Description2")
				@restaurant.reload
				expect(@restaurant.description).to eq("New Description2")
			end

			it "redirects to updated restaurant" do 
				patch :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:restaurant)
				expect(response).to redirect_to @restaurant
			end
		end

		context "valid reservation attributes" do
			it "a new reservation is successfully created" do 
				req_attributes = { 
					id: @restaurant.id, 
					reservations_attributes: [FactoryGirl.attributes_for(:reservation)] 
				} 
				patch :update, id: @restaurant, restaurant: req_attributes
				@restaurant.reload
				expect(@restaurant.reservations.count).to eq(2)
			end

			it "updates an existing reservation" do 
				req_attributes = {
						id: @restaurant.id, 
						reservations_attributes: { 
							id: @restaurant.reservations.first.id,
							message: "I have nut allergies"
						} 
					} 

				print req_attributes
				patch :update, id: @restaurant, restaurant: req_attributes
				@restaurant.reload
				expect(@restaurant.reservations.first.message).to eq("I have nut allergies")
			end

			it "current owner can delete an existing reservation" do 
				req_attributes = {
						id: @restaurant.id, 
						reservations_attributes: { 
							id: @restaurant.reservations.first.id,
							_destroy: 'true'
						} 
					} 

				print req_attributes
				patch :update, id: @restaurant, restaurant: req_attributes
				@restaurant.reload
				expect(@restaurant.reservations.count).to eq(0)
			end
		end

		context "invalid restaurant attributes" do
			it "loads restaurant for update" do
				patch :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:invalid_restaurant) 
				expect(assigns(:restaurant)).to eq(@restaurant)
			end

			it "does not update restaurant because of invalid attributes" do
				name = @restaurant.name
				patch :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:invalid_restaurant) 
				@restaurant.reload
				expect(@restaurant.name).to eq(name)
			end

			it "renders :edit view upon failing to update invalid restaurant" do 
				patch :update, id: @restaurant, restaurant: FactoryGirl.attributes_for(:invalid_restaurant) 
				expect(response).to render_template :edit
			end
		end

		context "current owner" do
			it "is not allowed to update restaurants of different ownership" do
				restaurant2 = FactoryGirl.create(:restaurant)
				patch :update, id: restaurant2, restaurant: FactoryGirl.attributes_for(:restaurant, description: "New Description2")
				expect(response).to render_template :edit
			end

			it "is not allowed to delete reservations of restaurants of different ownership" do
				restaurant2 = FactoryGirl.create(:restaurant)
				req_attributes = {
						id: restaurant2.id, 
						reservations_attributes: { 
							id: restaurant2.reservations.first.id,
							_destroy: 'true'
						} 
					} 

				#print restaurant2.reservations
				#print req_attributes
				patch :update, id: restaurant2, restaurant: req_attributes
				restaurant2.reload
				expect(restaurant2.reservations.count).to eq(1)
			end
		end

	end

end