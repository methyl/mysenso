# -*- encoding : utf-8 -*-
class Language
  include Mongoid::Document
  field :name
  key :name
  has_and_belongs_to_many :users
  
end
