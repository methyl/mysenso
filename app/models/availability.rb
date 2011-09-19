# -*- encoding : utf-8 -*-
class Availability
  include Mongoid::Document
  field :name

  has_and_belongs_to_many :users
end
