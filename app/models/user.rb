class User
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 
  field :first_name
  field :last_name
  field :phone_number, :type => Integer
  field :region
  field :city
  field :gender
  field :portfolio_name
  field :birth_date, :type => Date
  field :height, :type => Integer
  field :weight, :type => Integer
  field :bust, :type => Integer
  field :bra
  field :waist, :type => Integer
  field :hips, :type => Integer
  field :panties
  field :dress
  field :shoes, :type => Integer
  field :pants, :type => Integer
  field :neck, :type => Integer
  field :preferable_region
  field :about
  field :webpage
  field :courses
  field :references
  field :landline_number, :type => Integer
  field :fax_number, :type => Integer
  field :gadu_gadu, :type => Integer
  field :achievements
  field :profile_completed, :type => Boolean

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, :first_name, :last_name, :phone_number, :gender, :profession_id, :region_id, :city, :portfolio_name, :birth_date, :ethnicity_id, :hair_color_id, :eye_color_id, :weight, :height, :waist, :hips, :dress, :shoes, :pants, :neck, :prefered_region_id, :about, :webpage, :courses, :references, :language_ids, :discipline_ids, :gadu_gadu, :bra, :bust, :panties, :profile_completed, :achievements

  belongs_to :profession
  belongs_to :region
  belongs_to :ethnicity
  belongs_to :hair_color
  belongs_to :eye_color
  belongs_to :prefered_region
   
  has_and_belongs_to_many :languages
  has_and_belongs_to_many :disciplines
  has_and_belongs_to_many :availabilities

  validates_presence_of :profession, :profession_id, :gender
  validates_length_of :phone_number, :is => 9, :allow_blank => true
  validates_numericality_of :phone_number, :height, :weight, :waist, :hips, :bust, :shoes, :pants, :neck, :gadu_gadu, :on => :update, :allow_blank => true
  
  validates_presence_of :first_name, :last_name, :phone_number, :region, :region_id, :city, :portfolio_name, :birth_date, :prefered_region_id, :on => :update

  validates_presence_of :ethnicity, :ethnicity_id, :hair_color,:hair_color_id, :eye_color, :eye_color_id, :weight, :height, :waist, :hips, :dress, :shoes, :unless => Proc.new {|a| a.profession[:type] == 2 }
  validates_presence_of :bust, :bra, :if => :female_model?
  validates_presence_of :pants, :neck, :if => :male_model?

  validates_length_of :first_name, :within => 3..20, :allow_blank => true
  validates_length_of :last_name, :within => 3..40, :allow_blank => true

  

  after_save :update_languages # workaround
  after_update :set_profile_completed
  
  def profession_name
    if profession.type == 1
      "Modelka" if gender == 'female'
      "Model" if gender == 'male'
    end
    profession.name
  end

  def gender_string
    return 'Mężczyzna' if gender == 'male'
    return 'Kobieta' if gender == 'female'
  end

  def age
    age = ((Date.today - birth_date) / 1.year).ceil
    post = " lat"
    last = age.to_s[-1]
    post += 'a' if last == '2' or last == '3' or last == '4'
    age.to_s + post
  end

  private

  def female_model?
    profession[:type] != 2 and gender == 'female'
  end

  def male_model?
    profession[:type] !=2 and gender == 'male'
  end
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
