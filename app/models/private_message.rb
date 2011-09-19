# -*- encoding : utf-8 -*-
class PrivateMessage
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :content
  field :read, :type => Boolean, :default => false

  scope :unread, where(:read => false)

  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"

  validates_presence_of :title, :content, :sender_id, :receiver_id

  def read!
    self.update_attributes :read => true unless read == true
  end

  def unread?
    not self.read
  end
end
