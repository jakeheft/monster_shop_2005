require 'rails_helper'

describe "As an admin user I visit user's profile page" do
  it "I see same info user would see and no link to edit" do
    jake = User.create!(name: 'JakeBob',
                        address: '124 Main St',
                        city: 'Denver',
                        state: 'Colorado',
                        zip: '80202',
                        email: 'JBob1234@hotmail.com',
                        password: 'heftybags',
                        password_confirmation: 'heftybags',
                        role: 2)
    gare = User.create!(name: 'GarBob',
                        address: '124 Main St',
                        city: 'Denver',
                        state: 'Colorado',
                        zip: '80202',
                        email: 'GBob1234@hotmail.com',
                        password: 'heftybags',
                        password_confirmation: 'heftybags',
                        role: 0)
    greg = User.create!(name: 'GregBob',
                        address: '124 Main St',
                        city: 'Denver',
                        state: 'Colorado',
                        zip: '80202',
                        email: 'GrBob1234@hotmail.com',
                        password: 'heftybags',
                        password_confirmation: 'heftybags',
                        role: 0)

    visit "/login"

    fill_in :email, with: "JBob1234@hotmail.com"
    fill_in :password, with: "heftybags"
    click_button "Login"
    visit "/admin/users/#{greg.id}"

    expect(page).to have_content("Name: #{greg.name}")
    expect(page).to have_content("Address: #{greg.full_address}")
    expect(page).to have_content("Email: #{greg.email}")
  end
end
