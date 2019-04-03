require 'rails_helper'

RSpec.describe 'Login workflow' do
  before(:each) do
    @profile = {locator: 'Profile', href: profile_path}
    @merchant_dashboard = {locator: 'Dashboard', href: dashboard_path}
    @admin_dashboard = {locator: 'Dashboard', href: admin_dashboard_path}
    @log_out = {locator: 'Log Out', href: logout_path}
    @log_in = {locator: 'Log In', href: login_path}
    @register_user = {locator: 'Register User', href: new_user_path}
  end

  context '*as a registered user' do
    it '*can login a user' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to \
      receive(:current_user).and_return(user)

      visit root_path

      click_link "I already have an account"

      expect(current_path).to eq(login_path)
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_link "Log In"

      expect(current_path).to eq(profile_path)

      #sessions buttons
      expect(page).to have_content("Welcome, #{user.name}")
      expect(page).to have_link(@logout)
      expect(page).to_not have_link(@login)
      expect(page).to_not have_link(@register_user)
      #user role specific navigation bar
      expect(page).to have_link(@profile)
      expect(page).to_not have_link(@merchant_dashboard)
      expect(page).to_not have_link(@admin_dashboard)
    end
  end
end
