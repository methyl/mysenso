# -*- encoding : utf-8 -*-
class CreateDisciplines < ActiveRecord::Migration
  def self.up
    create_table :disciplines do |t|
      t.string :name
      t.string :account_type

      t.timestamps
    end
  end

  def self.down
    drop_table :disciplines
  end
end
