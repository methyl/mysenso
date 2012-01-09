class Album
  include Mongoid::Document
  field :title, :type => String
  field :description, :type => String
  field :public, :type => Boolean, :default => true
  
  has_many :photos
  has_one :thumbnail, :class_name => "Photo"
  belongs_to :user
  
  validates_presence_of :title, :description
  
  def thumbnail_url
    (thumbnail and thumbnail.image_url) ? thumbnail.image_url : "no_photo.png"
  end
end
