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

        expect(current_path).to eq("/users")
        expect(page).to have_content("State can't be blank")
      end
    end
  end

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
                           password_confirmation: 'heftybags',
                           role: 0
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

        expect(current_path).to eq("/users")

        expect(page).to have_content("Email has already been taken")
        expect(find_field(:name).value).to have_content('JimBob')
        expect(find_field(:address).value).to have_content('123 Main St')
        expect(find_field(:city).value).to have_content('Denver')
        expect(find_field(:state).value).to have_content('Colorado')
        expect(find_field(:zip).value).to have_content('80202')
      end
    end
  end

  describe "When I create a user" do
    it "password and password confirmation must match" do
      visit '/register'
      fill_in :name, with: 'JimBob'
      fill_in :address, with: '123 Main St'
      fill_in :city, with: 'Denver'
      fill_in :state, with: 'Colorado'
      fill_in :zip, with: '80202'
      fill_in :email, with: 'JBob1234@hotmail.com'
      fill_in :password, with: 'somethingdiff'
      fill_in :password_confirmation, with: 'somethingDiff'

      click_button "Register"

      expect(current_path).to eq("/users")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
