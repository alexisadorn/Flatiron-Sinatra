require_relative '../db/migrate/20150916154312_create_users.rb'

require_relative 'spec_helper'

describe 'user' do
  before do
    sql = "DROP TABLE IF EXISTS users"
    ActiveRecord::Base.connection.execute(sql)
    CreateUsers.new.up
  end

  it 'has a name' do
    user = User.new
    user.username = "Steven"
    user.password = "safepassword"
    user.save
    expect(User.where(username: "Steven").first).to eq(user)
  end
end
