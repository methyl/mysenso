# -*- encoding : utf-8 -*-
class EyeColor
  include Mongoid::Document
  field :name
  key :name
  has_many :users
end
