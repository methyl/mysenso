# -*- coding: utf-8 -*-
class User
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 

  # Common fields
  field :first_name
  field :last_name
  field :login
  field :phone_number, :type => Integer
  field :region
  field :webpage
  field :courses
  field :gadu_gadu, :type => Integer
  field :achievements
  field :profile_completed, :type => Boolean, :default => false
  field :avatar
  field :city

  # Profile fields
  field :gender
  field :birth_date, :type => Date
  field :height, :type => Integer
  field :weight, :type => Integer
  field :bust, :type => Integer
  field :waist, :type => Integer
  field :hips, :type => Integer
  field :panties
  field :dress
  field :shoes, :type => Integer
  field :pants, :type => Integer
  field :neck, :type => Integer
  field :preferable_region
  field :about

  # Company fields
  field :nip, :type => Integer
  field :regon, :type => Integer
  field :postcode
  field :street
  field :company_name
  field :landline_number, :type => Integer
  field :fax_number, :type => Integer
  field :description
  field :company, :type => Boolean, :default => false


  key :login


  # Devise configuration
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

 
  # Accessible attributes
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, :first_name, :last_name, :phone_number, :gender, :profession_id, :region_id, :city, :birth_date, :ethnicity_id, :hair_color_id, :eye_color_id, :weight, :height, :waist, :hips, :dress, :shoes, :pants, :neck, :prefered_region_id, :about, :webpage, :courses, :references, :language_ids, :discipline_ids, :gadu_gadu, :bra_id, :bust, :panties, :profile_completed, :achievements, :avatar, :company, :description, :fax_number, :landline_number, :company_name, :street, :postcode, :regon, :nip


  # Associations
  belongs_to :profession
  belongs_to :region
  belongs_to :ethnicity
  belongs_to :hair_color
  belongs_to :eye_color
  belongs_to :prefered_region
  belongs_to :bra

  has_many :photos
  has_many :sent_messages, :class_name => "PrivateMessage", :foreign_key => "sender_id"
  has_many :received_messages, :class_name => "PrivateMessage", :foreign_key => "receiver_id"
  has_many :references
  has_many :issued_references, :foreign_key => 'issuer_id'

  has_one :avatar
   
  has_and_belongs_to_many :languages
  has_and_belongs_to_many :disciplines
  has_and_belongs_to_many :availabilities


  # Common validations
  validates_length_of :phone_number, :is => 9, :allow_blank => true
  validates_length_of :first_name, :within => 3..20, :allow_blank => true
  validates_length_of :last_name, :within => 3..40, :allow_blank => true
  validates_numericality_of :phone_number, :height, :weight, :waist, :hips, :bust, :shoes, :pants, :neck, :gadu_gadu, :on => :update, :allow_blank => true

  validates_presence_of :first_name, :last_name, :city, :region, :region_id, :on => :update
  validates_presence_of :login
  validates_associated :region



  # Profile validations
  with_options :if => :profile? do |profile|
    profile.validates_presence_of :gender, :profession_id, :profession
    profile.validates_presence_of :birth_date, :prefered_region_id, :on => :update
    profile.validates_presence_of :ethnicity, :ethnicity_id, :hair_color, :hair_color_id, :eye_color, :eye_color_id, :weight, :height, :waist, :hips, :dress, :shoes, :unless => Proc.new {|a| a.profession[:type] == 2 }, :on => :update
    profile.validates_presence_of :bust, :bra, :bra_id, :if => :female_model?, :on => :update
    profile.validates_presence_of :pants, :neck, :if => :male_model?, :on => :update

    profile.validates_associated :profession
    profile.validates_associated :hair_color, :ethnicity, :eye_color, :bra, :on => :update
  end



  # Company validations
  with_options :if => :company? do |company|
    company.validates_presence_of :phone_number, :if => "landline_number.nil?", :on => :update
    company.validates_presence_of :landline_number, :if => "phone_number.nil?", :on => :update
    company.validates_presence_of :company_name, :street, :postcode, :on => :update
  end

  
  # Callbacks
  after_save :update_languages # workaround
  after_update :set_profile_completed

  # Scopes
  scope :completed, where(:profile_completed => true)

  def self.search(conditions)
    users = User.completed
    users = users.where(:city.in => conditions[:city]) unless conditions[:city].empty?
    users = users.where(:birth_date.lte => Date.today - conditions[:minimum_age].to_i.years) unless conditions[:minimum_age].blank?
    users = users.where(:birth_date.gte => Date.today - conditions[:maximum_age].to_i.years) unless conditions[:maximum_age].blank?
    ['ethnicity','hair_color','eye_color','gender', 'languages', 'disciplines', 'availabilities'].each do |param|
      users = users.where("#{param}_id".to_sym.in => conditions[param.to_sym]) unless conditions[param.to_sym].nil?
    end
    ['region','profession', 'prefered_region'].each do |param|
      users = users.where("#{param}_id".to_sym.in => conditions[param.to_sym]) unless conditions[param.to_sym].blank?
    end
    ['height', 'weight', 'waist', 'hips', 'bust', 'shoes', 'pants', 'neck'].each do |param|
      minimum = "minimum_#{param}".to_sym
      maximum = "maximum_#{param}".to_sym
      users = users.where(param.to_sym.gt => conditions[minimum]) unless conditions[minimum].blank?
      users = users.where(param.to_sym.lt => conditions[maximum]) unless conditions[maximum].blank?
    end
    users
  end

  def profile?
    not company
  end

  def company?
    company
  end

  def photos_limit_exceeded?
    photos.count > 4 ? true : false
  end

  def profession_name
    if profession.type == 1
      return "Modelka" if gender == 'female'
      return "Model" if gender == 'male'
    end
    profession.name
  end

  def gender_string
    return 'Mężczyzna' if gender == 'male'
    return 'Kobieta' if gender == 'female'
  end

  def age
    age = ((Time.now - birth_date.to_time) / 1.year).floor
    post = " lat"
    last = age.to_s[-1]
    post += 'a' if last == '2' or last == '3' or last == '4'
    age.to_s + post
  end

  def height_string
    height.to_s+" cm"
  end

  def weight_string
    weight.to_s+" kg"
  end

  def bust_string
    bust.to_s+" cm"
  end
  
  def waist_string
    waist.to_s+" cm"
  end

  def hips_string
    hips.to_s+" cm"
  end

  def neck_string
    neck.to_s+" cm"
  end

  def pants_string
    pants.to_s+" EU"
  end

  def dress_string
    dress.to_s+" cm"
  end

  def shoes_string
    shoes.to_s+" EU"
  end
    

    
  def female?
    gender == 'female'
  end

  def male?
    gender == 'male'
  end

  def female_model?
    profession[:type] != 2 and gender == 'female' if profession
  end

  def male_model?
    profession[:type] !=2 and gender == 'male' if profession
  end
  
  private
  
  def update_languages
    self.languages.each do |language|
      language.user_ids ||= []
      language.users << self unless language.users.include?(self)
      language.save
    end
  end

  def set_profile_completed
    unless profile_completed
      self.update_attributes :profile_completed => true
    end
  end

end
