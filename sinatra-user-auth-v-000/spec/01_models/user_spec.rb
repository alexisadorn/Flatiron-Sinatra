require 'spec_helper'

RSpec.describe User, type: :model do
  context "validations" do 
    it "is invalid without a name" do 
      expect(User.create(name: nil, email: "email@email.com", password: "password")).to_not be_valid
    end
    it "is invalid without an email" do 
      expect(User.create(name: "Harry Potter", email: nil, password: "password")).to_not be_valid
    end
    it "is invalid without a password" do 
      expect(User.create(name: "Harry Potter", email: "email@email.com", password: nil)).to_not be_valid
    end
  end

  context "attributes" do
    let(:user) {User.create(name: "Harry Potter", email: "email@email.com", password: "password")}
    it "has a name" do 
      expect(user.name).to eq("Harry Potter")
    end 

    it "has an email" do 
      expect(user.email).to eq("email@email.com")
    end

    it "has a password" do 
      expect(user.password).to eq("password")
    end
  end
end