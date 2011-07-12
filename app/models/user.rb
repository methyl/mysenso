class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, :first_name, :last_name, :phone_number, :gender, :profession_id

  belongs_to :profession

  validates_presence_of :profession
  validates_presence_of :gender
  validates_numericality_of :phone_number, :allow_blank => true
  validates_length_of :phone_number, :is => 9, :allow_blank => true
end
