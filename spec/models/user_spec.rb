require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new(:username => "Jimmy",
                     :email => "jimmy@example.com",
                     :password => "secret",
                     :password_confirmation => "secret")
  end
  
  it "is valid with valid attributes" do
    @user.should be_valid
  end
  it "is not valid without a username" do
    @user.username = nil
    @user.should_not be_valid
  end
  it "is not valid without a unique username" do
    @user2 = User.create( :username => "Jimmy",
                          :email => "johnny@example.com",
                          :password => "secret",
                          :password_confirmation => "secret")
    @user.should_not be_valid
  end
  it "is not valid without an email" do
    @user.email = nil
    @user.should_not be_valid
  end
  it "is not valid without a unique email" do
    @user2 = User.create( :username => "Johnny",
                          :email => "jimmy@example.com",
                          :password => "secret",
                          :password_confirmation => "secret")
    @user.should_not be_valid
  end
  
  it "is not valid without a password"

  it "is not valid without matching password and password confirmation" do
    @user.password = "wrong"
    @user.should_not be_valid
  end
  it "is not valid without a password confirmation" do
    @user.password_confirmation = nil
    @user.should_not be_valid
  end
end