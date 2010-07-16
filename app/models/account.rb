class Account < ActiveRecord::Base
  
  has_many :users, :dependent => :destroy
  
  accepts_nested_attributes_for :users
  authenticates_many :user_sessions, :find_options => { :limit => 1 } 
  
  validates_presence_of [:expiration_month, :expiration_year, :credit_card_number, :cvv], :on => :create
  
  attr_accessor :expiration_month, :expiration_year, 
                :credit_card_number, :cvv, :user
  
  before_destroy :cancel_subscription
                
  def create_and_subscribe(product_id)
    return unless self.valid?
    Account.transaction do
      self.save
      subscription = Chargify::Subscription.new(subscription_params(product_id))
      if subscription.save
        self.update_attributes!(:customer_id => subscription.customer.id, :subscription_id => subscription.id)
      else
        subscription.errors.full_messages.each{|err| errors.add_to_base(err)}
        false
        raise ActiveRecord::Rollback 
      end
    end
  end                

  def subscription
    Chargify::Subscription.find(subscription_id)
  end
  
  def customer
    Chargify::Customer.find(customer_id)
  end         
  
  private
  
    def cancel_subscription
      Chargify::Subscription.delete(subscription_id)
    end
  
    def customer_params
      {
        :first_name   => first_name,
        :last_name    => last_name,
        :email        => email,
        :reference    => id,
        :organization => "",      
      }
    end
  
    def subscription_params(product_id)
      {
        :product_id => product_id,
        :customer_attributes => customer_params,
        :credit_card_attributes => {
          :full_number => credit_card_number,        
          :cvv => cvv,
          :expiration_month => expiration_month,
          :expiration_year => expiration_year
        }      
      }
    end
       
end
