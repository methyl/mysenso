# -*- encoding : utf-8 -*-
class Region
  include Mongoid::Document
  field :name
  key :name
  has_many :users
end
