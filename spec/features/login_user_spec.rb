require "rails_helper"

RSpec.describe "Creating a new user", type: :feature do
  feature "Login do User" do
    scenario "Um user já registrado, com email e senha corretos" do
      user = FactoryBot.create(:user, password: "123123")
      visit new_user_session_path
      fill_in "Organization", with: user.organization.slug
      fill_in "Email", with: user.email
      fill_in "Password", with: "123123"
      click_on "Log in"
      expect(page).to have_content 'Signed in successfully.'
    end
  end
end
