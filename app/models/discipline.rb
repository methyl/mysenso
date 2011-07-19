class Discipline # < ActiveRecord::Base
  include Mongoid::Document
  
  field :name
  field :profession_types, :type => Array
  key :name
  has_and_belongs_to_many :users

end
