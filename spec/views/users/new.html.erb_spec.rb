require 'spec_helper'

describe "users/new.html.erb" do
  before(:each) do
    assign(:user, stub_model(User,
      :new_record? => true,
      :username => "MyString",
      :email => "MyString",
      :password => "MyString"
    ))
  end

  it "renders new user form" do
    render

    response.should have_selector("form", :action => users_path, :method => "post") do |form|
      form.should have_selector("input#user_username", :name => "user[username]")
      form.should have_selector("input#user_email", :name => "user[email]")
      form.should have_selector("input#user_password", :name => "user[password]")
    end
  end
end
