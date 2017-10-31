describe "Helpers" do 

  describe 'Helpers#current_user' do 
    it "returns the current user" do
      @user1 = User.create(:username => "skittles123", :password => "iluvskittles", :balance => 1000)

      session = {
        :user_id => 1
      }
      expect(Helpers.current_user(session)).to be_an_instance_of(User)
    end

  end

  describe 'Helpers#is_logged_in?' do 
    it "returns true or false" do
      @user1 = User.create(:username => "skittles123", :password => "iluvskittles", :balance => 1000)

      session = {
        :user_id => 1
      }
      expect(Helpers.is_logged_in?(session)).to eq(true)
    end

  end
end
