class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :account_id
      t.boolean :admin
      t.string :username
      t.string :email
      t.string :password
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.timestamps
    end
    add_index :users, :username
    add_index :users, :persistence_token
  end

  def self.down
    drop_table :users
  end
end
