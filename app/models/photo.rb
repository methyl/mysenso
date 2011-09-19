class Photo
  include Mongoid::Document
  field :title
  field :description
  
  belongs_to :discipline
  belongs_to :user

  mount_uploader :image, PhotoUploader

  validates_presence_of :image
  validates_presence_of :discipline
  validates_presence_of :user, :user_id

end
