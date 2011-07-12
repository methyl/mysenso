require 'acceptance/acceptance_helper'

feature 'Users', %q{
  In order to show my portfolio
  As a model
  I want to sign in.
} do


  scenario 'Signing in using correct creditentals' do
    sign_in
    page.should have_content "testing@gmail.com"
  end

  scenario 'Signing in using incorrect creditentals' do
    visit home_path
    within("#login_box") do
      fill_in "user_email", :with => "incorrect@gmail.com"
      fill_in "user_password", :with => "incorrect"
      click_button 'user_submit'
    end
    page.should have_content 'Niepoprawny adres email lub hasło.'
  end

  scenario 'Registering new user with correct data' do
    visit home_path
    within("#registration_box") do
      fill_in "user_email", :with => "new_user@gmail.com"
      fill_in "user_password", :with => "new_user_password"
      fill_in "user_password_confirmation", :with => "new_user_password"
      choose("Mężczyzna")
      select('Modelka', :from => 'user_profession')
      
      click_button 'user_submit'
      save_page
    end
    page.should have_content 'Rejestracja zakończyła się pomyślnie.'
  end

  scenario 'Registering new user with incorrect password' do
    visit home_path
    within("#registration_box") do
      fill_in "user_email", :with => "new_user@gmail.com"
      fill_in "user_password", :with => "short"
      fill_in "user_password_confirmation", :with => "doesntmatch"
      click_button 'user_submit'
    end
    page.should have_content 'jest za krótkie'
    page.should have_content 'nie zgadza się z potwierdzeniem'
  end

  scenario 'Signing out' do
    sign_in
    visit home_path
    click_link "Wyloguj się"
    page.should_not have_content "testing@gmail.com"
  end

  scenario 'Editing user profile' do
    sign_in
    visit home_path
    click_link "Edytuj profil"
    fill_in 'user_first_name', :with => 'Mariusz'
    fill_in 'user_last_name', :with => 'Kowalski'
    fill_in 'user_phone_number', :with => '766112123'
    select 'podkarpackie', :from => 'user_region'
    fill_in 'user_city', :with => 'Jasło'
    fill_in 'user_portfolio_name', :with => 'Lapis lazuri'
    fill_in 'user_birth_date', :with => '2011-07-12'
    select 'kaukaskie', :from => 'user_ethnicity'
    select 'blond', :from => 'user_hair'
    select 'zielone', :from => 'user_eyes'
    fill_in 'user_height', :with => '175'
    fill_in 'user_weight', :with => '45'
    fill_in 'user_bust', :with => '90'
    select 'C', :from => 'user_bra'
    fill_in 'user_waist', :with => '60'
    fill_in 'user_hips', :with => '10'
    fill_in 'user_panties', :with => '30'
    fill_in 'user_dress', :with => '31'
    fill_in 'user_shoes', :with => '39'
    fill_in 'user_pants', :with => '10'
    fill_in 'user_neck', :with => '10'
    select 'Cały świat', :from => 'user_preferable_region'
    fill_in 'user_about', :with => 'Jestem zajebisty'
    fill_in 'user_webpage', :with => 'nocuje.net'
    fill_in 'user_courses', :with => 'none'
    fill_in 'user_references', :with => 'none'

  end
end
