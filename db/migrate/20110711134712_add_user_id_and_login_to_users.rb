# -*- encoding : utf-8 -*-
class AddUserIdAndLoginToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :user_id, :integer
    add_column :users, :login, :string
  end

  def self.down
    remove_column :users, :login
    remove_column :users, :user_id
  end
end
