require 'spec_helper'

describe 'App' do
  include Rack::Test::Methods

  describe "GET '/'" do
    it "returns a 200 status code" do
      get '/'
      expect(last_response.status).to eq(200)
    end
  end

  describe "Signing Up" do

    it "displays Sign Up Page" do
      get '/signup'
      expect(last_response.body).to include('Username:')
      expect(last_response.body).to include('Password:')
    end

    it "displays the failure page if no username is given" do
      post '/signup', {"username" => "", "password" => "hello"}
      follow_redirect!
      expect(last_response.body).to include('Flatiron Bank Error')
    end

    it "displays the failure page if no password is given" do
      post '/signup', {"username" => "username", "password" => ""}
      follow_redirect!
      expect(last_response.body).to include('Flatiron Bank Error')
    end

    it "displays the log in page if username and password is given" do
      post '/signup', {"username" => "avi", "password" => "I<3Ruby"}
      follow_redirect!
      expect(last_response.body).to include('Login')
    end

  end

  describe "Logging In" do
    it "displays Log In Page" do
      get '/login'
      expect(last_response.body).to include('Username:')
      expect(last_response.body).to include('Password:')
    end

    it "displays the failure page if no username is given" do
      visit '/login'
      fill_in "username", with: ""
      fill_in "password", with: "test"
      click_button "Log In"
      expect(page.body).to include('Flatiron Bank Error')
      expect{page.get_rack_session_key("user_id")}.to raise_error(KeyError)
    end

    it "displays the failure page if no password is given" do
      visit '/login'
      fill_in "username", with: "sophie"
      fill_in "password", with: ""
      click_button "Log In"
      expect(page.body).to include('Flatiron Bank Error')
      expect(page.current_path).to eq("/failure")
      expect{page.get_rack_session_key("user_id")}.to raise_error(KeyError)
    end

    it "displays the user's account page if username and password is given" do
      @user = User.create(:username => "penelope", :password => "puppies")
      visit '/login'
      fill_in "username", :with => "penelope"
      fill_in "password", :with => "puppies"
      click_button "Log In"
      expect(page.current_path).to eq('/account')
      expect(page.status_code).to eq(200)
      expect(page.body).to include("We are currently working on your account.")
    end
  end

  describe "GET '/logout'" do
    it "clears the session" do
      get '/logout'
      expect{page.get_rack_session_key("user_id")}.to raise_error(KeyError)
    end
  end

  describe "User Model" do
    it "responds to authenticate method from has_secure_password" do
      @user = User.create(:username => "test123", :password => "test")
      expect(@user.authenticate("test")).to be_truthy
    end
  end

end
