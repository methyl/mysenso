# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  def set_inputs
    @regions = ['podkarpackie', 'małopolskie']
    @ethnicities = ['europejske', 'afrykańskie']
    @hair_colors = ['blond', 'ciemny blond']
    @eye_colors = ['zielone', 'niebieskie']
    @preferable_regions = ['województwo', 'cała Polska', 'cały świat']
    @languages = ['polski', 'angielski']
  end
  def after_sign_in_path_for(resource)
    if resource.profile_completed?
      stored_location_for(resource) || root_path
    else
      edit_user_path
    end
  end
end
