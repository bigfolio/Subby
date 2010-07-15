require 'spec_helper'

describe "users/index.html.erb" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :username => "MyUsername",
        :email => "MyEmail",
        :password => "MyPassword"
      ),
      stub_model(User,
        :username => "MyUsername",
        :email => "MyEmail",
        :password => "MyPassword"
      )
    ])
  end

  it "renders a list of users" do
    render
    response.should have_selector("tr>td", :content => "MyUsername".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyEmail".to_s, :count => 2)
  end
end
