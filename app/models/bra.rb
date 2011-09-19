class Bra
  include Mongoid::Document
  field :name, :type => String
  key :name

  has_many :users
end
