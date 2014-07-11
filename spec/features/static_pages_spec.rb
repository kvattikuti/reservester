require 'rails_helper'

describe "static pages" do

  describe "Home page" do

    it "welcome/index should have the content 'Home Page'" do
      visit '/welcome/index'
      expect(page).to have_content('Home Page')
    end

    it "/ should have the content 'Home Page'" do
      visit '/'
      expect(page).to have_content('Home Page')
    end

  end
end