class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
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
    if current_user.update_attributes(params[:user])
      redirect_to profile_edit_path, :notice => "Twoje dane zostały zaktualizowne." 
    else
      render :action => 'edit'
    end
  end

  def delete
  end

end
