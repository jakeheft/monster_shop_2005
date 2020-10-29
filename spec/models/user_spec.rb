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
                       role: 0
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
                         password_confirmation: 'heftybags',
                         role: 0
                        )
      expect(jake.valid_email).to eq(false)
    end
    it '#full_address' do 
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
      expect(jake.full_address).to eq('124 Main St, Denver, Colorado, 80202')
    end
  end

  describe "validations" do
    it { should validate_uniqueness_of :email }

    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
  end
end
