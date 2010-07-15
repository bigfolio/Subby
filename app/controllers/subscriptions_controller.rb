class SubscriptionsController < ApplicationController
  before_filter :get_product, :only => [:new, :create]
  skip_before_filter :current_account
  
  layout 'public'
  
  def new
    @account = Account.new
    @account.users.build
  end
  
  def create
    @account = Account.new params[:account]
    if @account.create_and_subscribe(@product.id)      
      redirect_to thanks_for_registering_url(:id => @account.id)
    else
      render :action => :new
    end
  end
  
  def thanks
    @account = Account.find(params[:id])
  end
  
  private
    def get_product
      @product = Chargify::Product.find(params[:product_id])    
    end
  
  
end
