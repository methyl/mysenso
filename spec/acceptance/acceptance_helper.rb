require 'spec_helper'

# Put your acceptance spec helpers inside spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

def create_valid_user
  user = Factory :user 
  # user.confirm!
end

def sign_in
  create_valid_user
  visit home_path
  within("#login_box") do
    fill_in "user_email", :with => "testing@gmail.com"
    fill_in "user_password", :with => "test123"
    click_button 'user_submit'
  end
  page.should have_content "testing@gmail.com"
end

def home_path
  '/'
end
