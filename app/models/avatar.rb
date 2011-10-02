# -*- encoding : utf-8 -*-
class Avatar
  include Mongoid::Document

  field :crop_x, :type => Integer
  field :crop_y, :type => Integer
  field :crop_w, :type => Integer
  field :crop_h, :type => Integer

  belongs_to :user
  
  validates_presence_of :user, :user_id

  mount_uploader :image, AvatarUploader

  after_update :reprocess_profile, :if => :cropping?



  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def profile_geometry
    img = Magick::Image::read(self.profile_url).first
    @geometry = {:width => img.columns, :height => img.rows }
  end

  def remove_avatar_and_crops
    self.destroy
    # self.update_attributes(:crop_x => nil, :crop_y => nil, :crop_h => nil, :crop_w => nil)
    
  end
  
  def reprocess_profile
    self.image.recreate_versions!
  end

end
