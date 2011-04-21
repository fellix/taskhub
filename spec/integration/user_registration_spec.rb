require 'spec_helper'

feature "registration" do
  scenario "register a new user with an avatar" do
    visit 'users/sign_up'
    within "#user_new" do
      fill_in "Name", :with => "Cid Moreira"
      fill_in "Email", :with => "cid@moreira.com"
      fill_in "Password", :with => "teste123"
      fill_in "Password confirmation", :with => "teste123"
      attach_file "Avatar", Rails.root.join('spec/fixtures/avatar.jpg')
      click_button "Salvar"
    end
    page.should have_content("Welcome! You have signed up successfully.")
  end
end