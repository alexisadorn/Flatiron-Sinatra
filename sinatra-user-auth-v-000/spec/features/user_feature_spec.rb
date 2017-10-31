require 'spec_helper'

describe "User sign up, log in, sign out" do 
  
  let!(:valid_user) {User.create(name: "Beini Huang", email: "beini@bee.com", password: "password")}
  
  describe "user sign up" do
    
    before(:each) do
      visit '/'
      click_link('Sign Up')
    end

    it 'successfully signs up with a name, email, and password' do 
      expect(current_path).to eq('/registrations/signup')
      fill_in("name", :with => valid_user.name)
      fill_in("email", :with => valid_user.email)
      fill_in("password", :with => valid_user.password)
      click_button('Sign Up')
      expect(current_path).to eq('/users/home')
      expect(page).to have_content("Welcome, #{valid_user.name}!")
    end

  end

  describe "user login" do 
    before(:each) do 
      visit '/'
      click_link('Log In')
    end

    it 'successfully logs in with an email and password' do 
      expect(current_path).to eq('/sessions/login')
      fill_in("email", :with => valid_user.email)
      fill_in("password", :with => valid_user.password)
      click_button('Log In')
      expect(current_path).to eq('/users/home')
      expect(page).to have_content("Welcome, #{valid_user.name}!")
    end

    it 'fails to log in with an incorrect password' do 
      expect(current_path).to eq('/sessions/login')
      fill_in("email", :with => valid_user.email)
      fill_in("password", :with => "wrong")
      click_button('Log In')
      expect(current_path).to eq('/sessions')
      expect(page).to have_content("undefined method `id' for nil:NilClass")
    end
  end

  describe "user log out" do 
    it 'successfully logs out and redirects to the homepage' do 
      visit '/'
      click_link('Log In')
      fill_in("email", :with => valid_user.email)
      fill_in("password", :with => valid_user.password)
      click_button('Log In')
      click_link('Log Out')
      expect(current_path).to eq('/')
      expect(page).to have_content('Log In')
    end
  end
end
