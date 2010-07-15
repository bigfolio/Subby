require 'spec_helper'

describe "user_sessions/new.html.erb" do
  before(:each) do
    assign(:user_session, stub_model(User,
      :new_record? => true,
      :username => "MyString",
      :password => "MyString"
    ))
  end

  it "renders login form" do
    render

    response.should have_selector("form", :action => login_path, :method => "post") do |form|
      form.should have_selector("input#user_username", :name => "user[username]")
      form.should have_selector("input#user_password", :name => "user[password]")
    end
  end
end