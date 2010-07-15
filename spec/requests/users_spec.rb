require 'spec_helper'

describe "Users" do
  
  before(:each) do
    @request.host = "test.example.com"
    @current_account = mock_model(Account)
    Account.stub!(:find_by_subdomain).and_return(@current_account)
  end
  
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
    end
  end
end
