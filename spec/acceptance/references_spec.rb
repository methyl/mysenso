# -*- encoding : utf-8 -*-

require 'acceptance/acceptance_helper'

feature 'References', %q{
  In order to say what do I think about a model
  As a photographer
  I want to leave a reference
} do


  scenario 'Adding new reference and accepting it' do
    photographer = Factory :photographer
    model = Factory :male_model
    sign_in_as('photographer@gmail.com', 'test123')
    visit user_profile_path(model.id)
    click_link "Zostaw referencję"
    fill_in "reference_content", :with => "Polecam współpracę z tym modelem"
    click_button "reference_submit"
    click_link "Wyloguj się"
    sign_in_as('male_model@gmail.com', 'test123')
    click_link 'Nowe referencje: 1'
    click_link 'Akceptuj'
    visit user_profile_path(model.id)
    page.should have_content 'Polecam współpracę z tym modelem'
    page.should have_content 'Brak nowych referencji'
  end


end
