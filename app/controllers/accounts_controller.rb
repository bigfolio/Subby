class AccountsController < ApplicationController

  def show
    @account = @current_account
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  def new
    @account = Account.new
    @products = Chargify::Product.find(:all) 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  def edit
    @account = @current_account
  end

  def create
    @account = @current_account
    respond_to do |format|
      if @account.save
        format.html { redirect_to(@account, :notice => 'Account was successfully created.') }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @account = @current_account
    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @account = @current_account
    @account.destroy
    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml  { head :ok }
    end
  end
end