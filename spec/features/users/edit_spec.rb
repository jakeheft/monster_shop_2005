describe "As a registered user" do
  describe "When I visit my edit profile page" do
    it "I see all fields populated with current info and 
    I can edit my information " do
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

      visit '/profile/edit'

      expect(find_field(:name).value).to have_content('JakeBob')
      expect(find_field(:address).value).to have_content('124 Main St')
      expect(find_field(:city).value).to have_content('Denver')
      expect(find_field(:state).value).to have_content('Colorado')
      expect(find_field(:zip).value).to have_content('80202')
      expect(find_field(:email).value).to have_content('JBob1234@hotmail.com')
      fill_in :name, with: 'edittest'
      click_button 'Update Profile'
      expect(current_path).to eq('/profile')
      expect(page).to have_content('Your profile has been updated')
      expect(page).to have_content('Name: edittest')
    end
  end
end
