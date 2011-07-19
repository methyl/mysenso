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
end
