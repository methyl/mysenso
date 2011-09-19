require 'spec_helper'

# Put your acceptance spec helpers inside spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
def create_valid_user
  user = Factory :user
  # user.confirm!
  return user
end

def sign_in
  user = create_valid_user
  visit home_path
  within("#login_box") do
    fill_in "user_email", :with => "testing@gmail.com"
    fill_in "user_password", :with => "test123"
    click_button 'user_submit'
  end
  page.should have_content "testing@gmail.com"
  return user 
end

def sign_in_as(email, password)
  visit home_path
  within("#login_box") do
    fill_in "user_email", :with => email
    fill_in "user_password", :with => password
    click_button 'user_submit'
  end
end

def sign_out
  visit home_path
  click_link 'Wyloguj się'
end

def create_photo
  sign_in
  click_link 'Twoje zdjęcia'
  fill_in "photo[title]", :with => "Fajne zdjęcie"
  fill_in "photo[description]", :with => "Z wakacji nad morzem 2011"
  path = File.join(::Rails.root, "photo.jpg")
  attach_file 'photo_image', path
  select "Fashion", :from => "photo_discipline_id"
  click_button 'photo_submit'
end

def home_path
  '/'
end

def user_profile_path(user_id=1)
  "/users/#{user_id}"
end
