class AddProfessionIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :profession_id, :integer
  end

  def self.down
    remove_column :users, :profession_id
  end
end
