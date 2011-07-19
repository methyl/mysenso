class Profession # < ActiveRecord::Base
  include Mongoid::Document

  field :name
  field :type, :type => Integer
  key :name
  has_many :users

  validates_presence_of :type
  validates_presence_of :name
end
