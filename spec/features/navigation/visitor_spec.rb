# frozen_string_literal: true

require 'rails_helper'

describe 'As a visitor' do
  describe 'I see a navigation bar' do
    it "'This navigation bar includes links for the following: a link to return to the welcome / home page of the application ( / ),
     a link to browse all items for sale /items),
     a link to see all merchants (/merchants), a link to my shopping cart (/cart),
     a link to log in (/login), a link to the user registration page (/register)" do
       visit '/merchants'

       expect(page).to have_link("Home")
       expect(page).to have_link("All Items")
       expect(page).to have_link("All Merchants")
       expect(page).to have_link("Cart")
       expect(page).to have_link("Log In")
       expect(page).to have_link("Register")
       expect(page).to have_content("0")
     end
  end
end
