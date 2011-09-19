class City
  include Mongoid::Document
  field :name, :type => String

  key :name
end
