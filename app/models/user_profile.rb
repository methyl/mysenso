class UserProfile < ActiveRecord::Base
belongs_to :user


validates_presence_of :login
validates_presence_of :first_name
validates_presence_of :last_name
validates_presence_of :phone_number
validates_uniqueness_of :login
validates_numericality_of :phone_number
validates_length_of :phone_number, :is => 9

end
