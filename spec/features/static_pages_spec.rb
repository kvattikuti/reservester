require 'rails_helper'

describe "static pages" do

  describe "Home page" do

    it "welcome/index should have the content 'Restaurant List'" do
      visit '/welcome/index'
      expect(page).to have_content('Restaurant List')
    end

    it "/ should have the content 'Restaurant List'" do
      visit '/'
      expect(page).to have_content('Restaurant List')
    end

  end
end