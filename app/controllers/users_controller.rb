# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update, :delete]

  def index
    per_page = 10
    if params[:search_companies]
      @users = User.companies.completed
      @users = @users.where(:region => params[:search_companies][:region]) if params[:region]
      @users = @users.where(:company_name => /#{params[:search_companies][:company_name]}/i) if params[:company_name]
      @users = @users.page(params[:page]).per(per_page)
    else
      @users = params[:search] ? User.profiles.search(params[:search]).page(params[:page]).per(per_page) : User.completed.profiles.page(params[:page]).per(per_page)
    end
  end

  def search
  end

  def search_companies
  end

  def show
    @user = defined?(params[:id]) ? User.find(params[:id]) : current_user
    @photos = @user.photos
    @references = @user.references.accepted
  end

  def edit
    @regions = Region.all
    unless current_user.company?
      @disciplines = Discipline.where(:profession_types => current_user.profession[:type])
      @ethnicities = Ethnicity.all
      @hair_colors = HairColor.all
      @eye_colors = EyeColor.all
      @prefered_regions = PreferedRegion.all
      @languages = Language.all
      @availability_items = Availability.all
      @professions = Profession.all
      @bras = Bra.all
      @height = (140..200).inject({}) {|h, n| h["#{n} cm"] = n; h}
      @weight = (35..120).inject({}) {|h, n| h["#{n} kg"] = n; h}
      @bust = (65..150).inject({}) {|h, n| h["#{n} cm"] = n; h}
      @waist = (50..110).inject({}) {|h, n| h["#{n} cm"] = n; h}
      @hips = (65..150).inject({}) {|h, n| h["#{n} cm"] = n; h}
      @dress = (10..100).inject({}) {|h, n| h["#{n} cm"] = n; h}
      @shoes = (30..48).inject({}) {|h, n| h["#{n} EU"] = n; h}
      @pants = (38..54).inject({}) {|h, n| h["#{n} EU"] = n; h}
      @neck = (18..45).inject({}) {|h, n| h["#{n} cm"] = n; h}
    end
  end

  def update
    edit
    current_user.user_validatable!
    if current_user.update_attributes(params[:user])
      redirect_to edit_user_path, :notice => "Twoje dane zostały zaktualizowne." 
    else
      render :action => 'edit'
    end
  end



  def delete
  end

end
