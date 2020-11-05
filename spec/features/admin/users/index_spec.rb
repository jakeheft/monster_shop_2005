require 'rails_helper'

describe "As an admin user when I click the 'Users' link in the nav" do
  it "I see all users in the system and their type/register date" do
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
    visit "/admin/users"

    within("#user-#{gare.id}") do
      expect(page).to have_link(gare.name)
      expect(page).to have_content(gare.created_at)
      expect(page).to have_content(gare.role)

      click_on(gare.name)
      expect(current_path).to eq("/admin/users/#{gare.id}")
    end
  end
end
