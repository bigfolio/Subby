class PublicController < ApplicationController
  skip_before_filter :current_account
  
  def index
  end

  def contact
  end

end
