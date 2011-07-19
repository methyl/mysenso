require 'acceptance/acceptance_helper'

feature 'Users', %q{
  In order to show my portfolio
  As a model
  I want to sign in and manage my profile.
} do

  before(:each) do
    # Factory :profession
    # 16.times { Factory :region }
  end
  scenario 'Signing in using correct creditentals' do
    sign_in
    "testing@gmail.com"
  end

  scenario 'Signing in using incorrect creditentals' do
    visit home_path
    within("#login_box") do
      fill_in "user_email", :with => "incorrect@gmail.com"
      fill_in "user_password", :with => "incorrect"
      click_button 'user_submit'
    end
    'Niepoprawny adres email lub hasło.'
  end

  scenario 'Registering new user with correct data' do
    visit home_path
    within("#registration_box") do
      fill_in "user_email", :with => "new_user@gmail.com"
      fill_in "user_password", :with => "new_user_password"
      fill_in "user_password_confirmation", :with => "new_user_password"
      choose("Mężczyzna")
      save_page
      select('Modelka', :from => 'user_profession_id')
      
      click_button 'user_submit'
    end
    'Rejestracja zakończyła się pomyślnie.'
  end

  scenario 'Registering new user with incorrect password' do
    visit home_path
    within("#registration_box") do
      fill_in "user_email", :with => "new_user@gmail.com"
      fill_in "user_password", :with => "short"
      fill_in "user_password_confirmation", :with => "doesntmatch"
      click_button 'user_submit' 
    end
    'jest za krótkie'
    'nie zgadza się z potwierdzeniem'
  end

  scenario 'Signing out' do
    sign_in
    visit home_path
    click_link "Wyloguj się"
    page.should_not have_content "testing@gmail.com"
  end

  scenario 'Editing user profile' do
    # for male
    sign_in
    visit home_path
    click_link "Edytuj swój profil"
    save_page
    fill_in 'user_first_name', :with => 'Mariusz'
    fill_in 'user_last_name', :with => 'Kowalski'
    fill_in 'user_phone_number', :with => '766112123'
    select 'podkarpackie', :from => 'user_region_id'
    fill_in 'user_city', :with => 'Jasło'
    fill_in 'user_portfolio_name', :with => 'Lapis lazuri'
    select '21', :from => 'user_birth_date_3i'
    select 'styczeń', :from => 'user_birth_date_2i'
    select '2000', :from => 'user_birth_date_1i'
    select 'inne', :from => 'user_ethnicity_id'
    select 'blond', :from => 'user_hair_color_id'
    select 'zielone', :from => 'user_eye_color_id'
    fill_in 'user_height', :with => '175'
    fill_in 'user_weight', :with => '45'
    fill_in 'user_waist', :with => '60'
    fill_in 'user_hips', :with => '10'
    fill_in 'user_dress', :with => '31'
    fill_in 'user_shoes', :with => '39'
    fill_in 'user_pants', :with => '10'
    fill_in 'user_neck', :with => '10'
    select 'cały świat', :from => 'user_prefered_region_id'
    check 'polski'
    check 'angielski'
    fill_in 'user_about', :with => 'Jestem zajebisty'
    fill_in 'user_webpage', :with => 'nocuje.net'
    fill_in 'user_courses', :with => 'none'
    fill_in 'user_gadu_gadu', :with => '31231231'
    fill_in 'user_references', :with => 'none'
    click_button 'user_submit'
    save_page
    'Twoje dane zostały zaktualizowne.'
  
  end

  scenario "Displaying correct form fields for female model" do
    Factory :user, :email => 'testing_female@gmail.com', :gender => "female"
    sign_in_as('testing_female@gmail.com', 'test123')
    visit home_path
    click_link 'Edytuj swój profil'
    ['Kolor włosów', 'Kolor oczu', 'Wzrost', 'Waga', 'Biust', 'Biustonosz', 'Talia', 'Biodra', 'Ubranie', 'Obuwie', 'Zakres pracy', 'Preferowany region pracy', 'Języki', 'O sobie', 'Twoja strona WWW', 'Numer Gadu-Gadu', 'Kursy, szkolenia', 'Referencje'].each do |item|
      page.should have_content item
    end
    ['Kołnierzyk', 'Spodnie', 'Dyspozycyjność'].each do |item|
      page.should_not have_content item
    end
    
  end

  scenario 'Displaying correct form fields for male model' do
    sign_in #default male model
    visit home_path
    click_link 'Edytuj swój profil'
    ['Kolor włosów', 'Kolor oczu', 'Wzrost', 'Waga', 'Talia', 'Biodra', 'Ubranie', 'Obuwie','Spodnie','Kołnierzyk', 'Zakres pracy', 'Preferowany region pracy', 'Języki', 'O sobie', 'Twoja strona WWW', 'Numer Gadu-Gadu', 'Kursy, szkolenia', 'Referencje'].each do |item|
      page.should have_content item
    end
    ['Biust', 'Biustonosz', 'Dyspozycyjność'].each do |item|
      page.should_not have_content item
    end
  end

  scenario 'Displaying correct form fields for photographer' do
    profession = Factory :profession, :name => "Fotograf", :type => 2
    Factory :user, :email => 'testing_photographer@gmail.com', :profession => profession
    sign_in_as('testing_photographer@gmail.com', 'test123')
    visit home_path
    click_link 'Edytuj swój profil'
    ['Zakres pracy', 'Preferowany region pracy', 'O sobie', 'Twoja strona WWW', 'Kursy, szkolenia', 'Referencje', 'Osiągnięcia'].each do |item|
      page.should have_content item
    end
    ['Kolor włosów', 'Kolor oczu', 'Wzrost', 'Waga', 'Talia', 'Biodra', 'Ubranie', 'Obuwie','Spodnie','Kołnierzyk', 'Biust','Biustonosz','Kołnierzyk', 'Spodnie', 'Dyspozycyjność'].each do |item|
      page.should_not have_content item
    end
  end
  scenario 'Displaying correct form fields for female host' do
    profession = Factory :profession, :name => "Host / Hostessa", :type => 3
    Factory :user, :email => 'testing_hostessa@gmail.com', :profession => profession, :gender => 'female'
    sign_in_as('testing_hostessa@gmail.com', 'test123')
    visit home_path
    click_link 'Edytuj swój profil'
    ['Kolor włosów', 'Kolor oczu', 'Wzrost', 'Waga', 'Biust', 'Biustonosz', 'Talia', 'Biodra', 'Ubranie', 'Obuwie', 'Zakres pracy', 'Preferowany region pracy', 'Języki', 'O sobie', 'Twoja strona WWW', 'Numer Gadu-Gadu', 'Kursy, szkolenia', 'Referencje', 'Dyspozycyjność'].each do |item|
      page.should have_content item
    end
    ['Kołnierzyk', 'Spodnie'].each do |item|
      page.should_not have_content item
    end
  end
  scenario 'Displaying correct form fields for male host' do
    profession = Factory :profession, :name => "Host / Hostessa", :type => 3
    Factory :user, :email => 'testing_host@gmail.com', :profession => profession, :gender => 'male'
    sign_in_as('testing_host@gmail.com', 'test123')
    visit home_path
    click_link 'Edytuj swój profil'
    ['Kolor włosów', 'Kolor oczu', 'Wzrost', 'Waga', 'Kołnierzyk', 'Spodnie', 'Talia', 'Biodra', 'Ubranie', 'Obuwie', 'Zakres pracy', 'Preferowany region pracy', 'Języki', 'O sobie', 'Twoja strona WWW', 'Numer Gadu-Gadu', 'Kursy, szkolenia', 'Referencje', 'Dyspozycyjność'].each do |item|
      page.should have_content item
    end
    ['Biust', 'Biustonosz'].each do |item|
      page.should_not have_content item
    end
  end
end
