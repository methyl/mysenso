class Album
  include Mongoid::Document
  field :title, :type => String
  field :description, :type => String
  field :public, :type => Boolean, :default => true
  
  key :title
  
  has_many :photos
  belongs_to :user
  
  validates_presence_of :title, :description
    
  def thumbnail
    photos.thumbnails.first
  end
  
  def thumbnail_url
    (thumbnail and thumbnail.image_url) ? thumbnail.image_url : "no_photo.png"
  end
end
