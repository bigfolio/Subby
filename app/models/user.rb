class User < ActiveRecord::Base
  
  belongs_to :account
  
  acts_as_authentic
  
end
