class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update, :delete]

  def index
    @users = params[:search] ? User.search(params[:search]).page(params[:page]).per(3) : User.completed.page(params[:page]).per(1)
  end

  def search
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
    end
  end

  def update
    edit
    if current_user.update_attributes(params[:user])
      redirect_to edit_user_path, :notice => "Twoje dane zostały zaktualizowne." 
    else
      render :action => 'edit'
    end
  end



  def delete
  end

end
