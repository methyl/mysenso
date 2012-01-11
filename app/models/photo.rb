# -*- encoding : utf-8 -*-
class Photo
  include Mongoid::Document
  field :title
  field :description
  field :thumbnail, :type => Boolean, :default => false
  
  key :title
  
  belongs_to :discipline
  belongs_to :user
  belongs_to :album

  mount_uploader :image, PhotoUploader
  
  scope :thumbnails, where(:thumbnail => true)

  validates_presence_of :image
  validates_presence_of :discipline
  validates_presence_of :user, :user_id
  
  def thumbnail!
    album.photos.each {|photo| photo.update_attribute(:thumbnail, false)}
    self.update_attribute(:thumbnail, true)
  end

end
