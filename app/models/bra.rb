# -*- encoding : utf-8 -*-
class Bra
  include Mongoid::Document
  field :name, :type => String
  key :name

  has_many :users
end
