# -*- encoding : utf-8 -*-
class AddLanguagesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :languages, :text
  end

  def self.down
    remove_column :users, :languages
  end
end
