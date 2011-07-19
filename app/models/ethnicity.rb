class Ethnicity
  include Mongoid::Document
  field :name
  key :name
  has_many :users
end
