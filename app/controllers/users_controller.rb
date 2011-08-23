class UsersController < ApplicationController
  autocomplete :city, :name

  def index
    @users = params[:search] ? User.search(params[:search]).page(params[:page]).per(1) : User.all.page(params[:page]).per(1)
  end

  def search
  end

  def show
    @user = current_user || User.find(params[:id])
    @photos = @user.photos
  end

  def edit
    @disciplines = Discipline.where(:profession_types => current_user.profession.type)
    @regions = Region.all
    @ethnicities = Ethnicity.all
    @hair_colors = HairColor.all
    @eye_colors = EyeColor.all
    @prefered_regions = PreferedRegion.all
    @languages = Language.all
    @availability_items = Availability.all
    @professions = Profession.all
    @bras = Bra.all
  end

  def update
    @disciplines = Discipline.where(:profession_types => current_user.profession.type)
    @regions = Region.all
    @ethnicities = Ethnicity.all
    @hair_colors = HairColor.all
    @eye_colors = EyeColor.all
    @prefered_regions = PreferedRegion.all
    @languages = Language.all
    @availability_items = Availability.all
    @professions = Profession.all
    @bras = Bra.all
    if current_user.update_attributes(params[:user])
      redirect_to edit_user_path, :notice => "Twoje dane zostały zaktualizowne." 
    else
      render :action => 'edit'
    end
  end



  def delete
  end

end
