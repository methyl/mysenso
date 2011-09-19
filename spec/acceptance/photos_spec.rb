require 'acceptance/acceptance_helper'

feature 'Photos', %q{
  In order to show my portfolio
  As a model
  I want to upload my photos
} do

  before :each do
    create_photo
    click_link 'Twoje zdjęcia'
  end


  scenario 'Adding and viewing new photo' do
    page.should have_content 'Fajne zdjęcie'
    find(:xpath, "//a/img[@class='photo']/..").click
    page.should have_content "Fashion"
    page.should have_content "Fajne zdjęcie"
    page.should have_content "Z wakacji nad morzem 2011"
    page.should have_selector("img[class='photo']")
  end

  scenario 'Removing photo' do
    click_link 'Usuń'
    page.should_not have_content 'Fajne zdjęcie'
  end

  scenario 'Editing photo' do
    click_link 'Edytuj'
    fill_in :photo_title, :with => 'Nowy tytuł'
    click_button :photo_submit
    page.should have_content 'Nowy tytuł'
    page.should_not have_content 'Fajne zdjęcie'
  end


end
