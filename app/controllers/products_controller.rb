class ProductsController < ApplicationController
  skip_before_filter :current_account
  
  def index
    @products = Chargify::Product.find(:all)    
  end
end
