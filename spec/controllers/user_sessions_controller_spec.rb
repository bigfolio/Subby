require 'spec_helper'

describe UserSessionsController do
  
  before(:each) do
    @request.host = "test.example.com"
    @current_account = mock_model(Account)
    Account.stub!(:find_by_subdomain).and_return(@current_account)
  end
  
  def mock_usersession(stubs={})
    @mock_usersession ||= mock_model(UserSession, stubs).as_null_object
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "destroys the current session" do
      UserSession.should_receive(:find).with("37") { mock_usersession }
      mock_usersession.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
    
    it "redirects to the login page" do
      UserSession.stub(:find) { mock_usersession(:destroy => true) }
      delete :destroy
      response.should redirect_to(login_url)
    end
  end

end
