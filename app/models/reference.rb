class Reference
  include Mongoid::Document

  field :content
  field :accepted, :type => Boolean, :default => false

  scope :unaccepted, where(:accepted => false)
  scope :accepted, where(:accepted => true)

  belongs_to :user
  belongs_to :issuer, :class_name => "User"
end
