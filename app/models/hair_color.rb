# -*- encoding : utf-8 -*-
class HairColor
  include Mongoid::Document
  field :name
  key :name
  has_many :users
end
