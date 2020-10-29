require 'rails_helper'

describe "As a registered user" do
  describe "When I visit my password edit page" do
    it "I am able to edit my password and am redirected to my profile page" do
      jake = User.create!( name: 'JakeBob',
                           address: '124 Main St',
                           city: 'Denver',
                           state: 'Colorado',
                           zip: '80202',
                           email: 'JBob1234@hotmail.com',
                           password: 'heftybags',
                           password_confirmation: 'heftybags',
                           role: 0
                          )
      visit '/login'

      fill_in :email, with: 'JBob1234@hotmail.com'
      fill_in :password, with: 'heftybags'
      click_button 'Login'

      visit '/password/edit'
      fill_in :password, with: "testpassword"
      fill_in :password_confirmation, with: 'testpassword'
      click_button 'Change Password'
      password_digest = '$2a$04$OkF/X97WsdeVjco9W8pJHucP15Y7CiuYz3Qbe2AGpqCe6ultBjUhK'
      expect(current_path).to eq('/profile')
      expect(page).to have_content('Your password has been changed')
      expect(jake.password_digest).not_to eq(password_digest)
    end

    it "I am able to edit my password and am redirected to my profile page" do
      jake = User.create!( name: 'JakeBob',
                           address: '124 Main St',
                           city: 'Denver',
                           state: 'Colorado',
                           zip: '80202',
                           email: 'JBob1234@hotmail.com',
                           password: 'heftybags',
                           password_confirmation: 'heftybags',
                           role: 0
                          )
      visit '/login'

      fill_in :email, with: 'JBob1234@hotmail.com'
      fill_in :password, with: 'heftybags'
      click_button 'Login'
      visit '/password/edit'
      click_button 'Change Password'
      expect(current_path).to eq('/password/edit')
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
