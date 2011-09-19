require 'acceptance/acceptance_helper'

feature 'Messaging', %q{
  In order to contact with my friends or photographer
  As a user
  I want to send and recieve private messages
} do


  scenario 'Sending a private message to user' do
    sender = Factory :male_model
    receiver = Factory :photographer
    sign_in_as(sender.email, 'test123')
    visit user_profile_path(receiver.login)
    save_page
    click_link "Wyślij prywatną wiadomość"
    fill_in 'private_message[title]', :with => "Pytanie o sesję"
    fill_in 'private_message[content]', :with => "Zróbmy coś wyjebistego"
    click_button :private_message_submit
    click_link "Brak nowych wiadomości"
    page.should have_content "Pytanie o sesję"
    click_link "Wyloguj się"
    sign_in_as(receiver.email, 'test123')
    page.should have_content "Nowe wiadomości: 1"
    page.should_not have_content "Brak nowych wiadomości"
    click_link "Nowe wiadomości: 1"
    click_link "Pytanie o sesję"
    page.should have_content "Pytanie o sesję"
    page.should have_content "Zróbmy coś wyjebistego"
    visit home_path
    page.should have_content "Brak nowych wiadomości"
  end

end
