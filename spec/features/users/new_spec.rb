# User Story 10, User Registration
#
# As a visitor
# When I click on the 'register' link in the nav bar
# Then I am on the user registration page ('/register')
# And I see a form where I input the following data:
# - my name
# - my street address
# - my city
# - my state
# - my zip code
# - my email address
# - my preferred password
# - a confirmation field for my password
#
# When I fill in this form completely,
# And with a unique email address not already in the system
# My details are saved in the database
# Then I am logged in as a registered user
# I am taken to my profile page ("/profile")
# I see a flash message indicating that I am now registered and logged in
require 'rails_helper'

describe "As a visitor" do
  describe "When I click on the 'register' link in the nav bar" do
    it "I see a form to input data" do

      visit '/register'
      fill_in :name, with: 'JimBob'
      fill_in :address, with: '123 Main St'
      fill_in :city, with: 'Denver'
      fill_in :state, with: 'Colorado'
      fill_in :zip, with: '80202'
      fill_in :email, with: 'JimBob3003@aol.com'
      fill_in :password, with: 'somethingdiff'
      fill_in :password_confirmation, with: 'somethingdiff'

      click_button "Register"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("You are now registered and logged in")

    end
  end

  # User Story 11, User Registration Missing Details
  #
  # As a visitor
  # When I visit the user registration page
  # And I do not fill in this form completely,
  # I am returned to the registration page
  # And I see a flash message indicating that I am missing required fields

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

#   User Story 12, Registration Email must be unique
#
# As a visitor
# When I visit the user registration page
# If I fill out the registration form
# But include an email address already in the system
# Then I am returned to the registration page
# My details are not saved and I am not logged in
# The form is filled in with all previous data except the email field and password fields
# I see a flash message telling me the email address is already in use

  describe 'As a visitor when I visit the user registration page' do
    describe 'If I fill out the registration form but my email is taken' do
      it 'I am returned to the registration page and I see a flash message' do
        jake = User.create!(name: 'JakeBob',
                           address: '124 Main St',
                           city: 'Denver',
                           state: 'Colorado',
                           zip: '80202',
                           email: 'JBob1234@hotmail.com',
                           password: 'heftybags',
                           password_confirmation: 'heftybags'
                          )

        visit '/register'
        fill_in :name, with: 'JimBob'
        fill_in :address, with: '123 Main St'
        fill_in :city, with: 'Denver'
        fill_in :state, with: 'Colorado'
        fill_in :zip, with: '80202'
        fill_in :email, with: 'JBob1234@hotmail.com'
        fill_in :password, with: 'somethingdiff'
        fill_in :password_confirmation, with: 'somethingdiff'

        click_button "Register"

        expect(current_path).to eq("/register")

        expect(page).to have_content("That email address is already in use!")
        expect(find_field(:name).value).to have_content('JimBob')
        expect(find_field(:address).value).to have_content('123 Main St')
        expect(find_field(:city).value).to have_content('Denver')
        expect(find_field(:state).value).to have_content('Colorado')
        expect(find_field(:zip).value).to have_content('80202')
      end
    end
  end
end
