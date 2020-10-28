# frozen_string_literal: true

require 'rails_helper'

describe 'As an admin' do
  describe 'I see the same links as a regular user' do
    it 'Plus the following links, a link to my admin dashboard ("/admin"), a link to see all users ("/admin/users")' do
      jake = User.create!(name: 'JakeBob',
                          address: '124 Main St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '80202',
                          email: 'JBob1234@hotmail.com',
                          password: 'heftybags',
                          password_confirmation: 'heftybags',
                          role: 2)

      visit '/login'
      fill_in :email, with: jake.email
      fill_in :password, with: jake.password

      expect(page).to have_link('Home')
      expect(page).to have_link('All Items')
      expect(page).to have_link('All Merchants')
      expect(page).to have_link('Cart')
      expect(page).to have_link('Register')
      expect(page).to have_content('0')
      click_on 'Login'
      expect(page).to have_link('My Profile')
      expect(page).to have_link('Admin Dashboard')
      expect(page).to have_link('All Users')
      expect(page).to have_link('Log Out')
      expect(page).not_to have_link('Cart')
      expect(page).not_to have_link('Log In')
      expect(page).not_to have_link('Register')
      expect(page).not_to have_content('0')
      expect(page).to have_content("Logged in as #{jake.name}")
    end
  end
  describe 'When I try to access any path that begins with the following, then I see a 404 error:' do
    it "'/merchant' '/cart'" do
      jake = User.create!(name: 'JakeBob',
                          address: '124 Main St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '80202',
                          email: 'JBob1234@hotmail.com',
                          password: 'heftybags',
                          password_confirmation: 'heftybags',
                          role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(jake)
      visit "/merchant"

      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit "/cart"

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end
