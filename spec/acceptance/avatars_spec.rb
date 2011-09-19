require 'acceptance/acceptance_helper'

feature 'Avatars', %q{
  In order to show how I am looking
  As a model
  I want to upload my avatar
} do


  scenario 'Adding new avatar' do
    sign_in
    click_link 'Edytuj avatar'
    path = File.join(::Rails.root, "avatar.jpg")
    attach_file 'avatar_image', path
    click_button 'avatar_submit'
    page.should have_selector("img[id='cropbox']")
  end


end
