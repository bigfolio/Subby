class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string   :name
      t.string   :first_name
      t.string   :last_name
      t.string   :email
      t.string   :domain
      t.string   :subdomain
      t.integer  :customer_id
      t.integer  :subscription_id
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
