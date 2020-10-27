# User Story 11, User Registration Missing Details
#
# As a visitor
# When I visit the user registration page
# And I do not fill in this form completely,
# I am returned to the registration page
# And I see a flash message indicating that I am missing required fields
require 'rails_helper'

describe 'As a visitor, when I visit the user registration page' do
  describe 'And I do not fill in the form completely' do
    it 'I get a flash message and am returned to the registration page' do

      visit '/register'
      fill_in :name, with: 'JimBob'
      fill_in :address, with: '123 Main St'
      fill_in :city, with: 'Denver'
      fill_in :zip, with: '80202'
      fill_in :email, with: 'JimBob3003@aol.com'
      fill_in :password, with: 'somethingdiff'
      fill_in :password_confirmation, with: 'somethingdiff'

      click_button "Register"

      expect(current_path).to eq("/register")
      expect(page).to have_content("You are missing required field(s)")
    end
  end
end
