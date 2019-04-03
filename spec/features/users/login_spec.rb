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

      visit root_path

      click_link "Login"

      expect(current_path).to eq(login_path)
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_button "Log In"

      expect(current_path).to eq(profile_path)
    end
  end

  context '*as a registered admin' do
    it '*can login an admin' do
      admin = create(:admin)

      visit root_path

      click_link "Login"

      expect(current_path).to eq(login_path)
      fill_in "email", with: admin.email
      fill_in "password", with: admin.password
      click_button "Log In"

      expect(current_path).to eq(root_path)
    end

    xit '*stays on the page when credentials bad' do

    end
  end
end
# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to the home page of the site
# And I see a flash message that I am logged in
