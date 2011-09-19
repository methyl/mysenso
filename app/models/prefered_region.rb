# -*- encoding : utf-8 -*-
class PreferedRegion
  include Mongoid::Document
  field :name
  key :name
  has_many :users
end
