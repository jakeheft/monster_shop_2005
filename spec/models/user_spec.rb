require 'rails_helper'

describe User, type: :model do
  describe "password attributes" do
    it "needs password confirmation" do
    jake = User.create(name: 'JakeBob',
                       address: '124 Main St',
                       city: 'Denver',
                       state: 'Colorado',
                       zip: '80202',
                       email: 'JBob1234@hotmail.com',
                       password: 'heftybags',
                      )

      expect(User.find_by(name: "JakeBob")).to eq(nil)
    end
  end

  describe 'instance methods' do
    it '#valid_email' do
      jake = User.create!(name: 'JakeBob',
                         address: '124 Main St',
                         city: 'Denver',
                         state: 'Colorado',
                         zip: '80202',
                         email: 'JBob1234@hotmail.com',
                         password: 'heftybags',
                         password_confirmation: 'heftybags'
                        )
      expect(jake.valid_email).to eq(false)
    end
  end
end
