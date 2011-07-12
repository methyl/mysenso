class AddUserProfileFieldsToUsers < ActiveRecord::Migration
  def self.up
   change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :phone_number
      t.string :region
      t.string :city
      t.string :portfolio_name
      t.date :birth_date
      t.string :gender
      t.string :ethnicity
      t.string :hair
      t.string :eyes
      t.integer :height
      t.integer :weight
      t.string :bust
      t.string :bra
      t.integer :waist
      t.integer :hips
      t.string :panties
      t.integer :dress
      t.integer :shoes
      t.integer :pants
      t.integer :neck
      t.string :preferable_region
      t.string :about
      t.string :webpage
      t.string :courses
      t.string :references
      t.integer :landline_number
      t.integer :fax_number
      t.string :achievements

    end
  end

  def self.down
    remove_column :users, :first_name, :last_name, :phone_number, :region, :city, :portfolio_name, :birth_date, :gender, :ethnicity, :hair, :eyes, :height, :weight, :bust, :bra, :waist, :hips, :panties, :dress, :shoes, :pants, :neck, :preferable_region, :about, :webpage, :courses, :references, :landline_number, :fax_number, :achievements
  end

end
