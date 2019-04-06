require 'rails_helper'

RSpec.describe 'Login workflow' do
  describe 'happy path' do
    # before(:each) do
    #   @profile = {locator: 'Profile', href: profile_path}
    #   @merchant_dashboard = {locator: 'Dashboard', href: dashboard_path}
    #   @admin_dashboard = {locator: 'Dashboard', href: admin_dashboard_path}
    #   @log_out = {locator: 'Log Out', href: logout_path}
    #   @log_in = {locator: 'Log In', href: login_path}
    #   @register_user = {locator: 'Register User', href: new_user_path}
    # end

    context '*as a registered user' do
      it '*can login a user' do
        user = create(:user)

        visit root_path

        click_link "Login"

        expect(current_path).to eq(login_path)
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        click_button "Log In"

        expect(page).to have_content("You are now logged in as #{user.email}.")
        expect(current_path).to eq(profile_path)
        expect(page).to have_content(user.name)
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

        expect(page).to have_content("You are now logged in as #{admin.email}.")
        expect(current_path).to eq(root_path)
      end
    end

    context '*as a registered merchant' do
      it '*can login an merchant' do
        merchant = create(:merchant)

        visit root_path

        click_link "Login"

        expect(current_path).to eq(login_path)
        fill_in "email", with: merchant.email
        fill_in "password", with: merchant.password
        click_button "Log In"

        expect(page).to have_content("You are now logged in as #{merchant.email}.")
        expect(current_path).to eq(dashboard_path)
      end
    end
  end

  describe '*sad path' do
    context '*as a visitor' do
      it '*cannot login with bad password' do
        user = create(:user)

        visit root_path

        click_link('Login')

        expect(current_path).to eq(login_path)
        fill_in('Email', with: user.email)
        fill_in('Password', with: 'wrong password')
        click_button('Log In')

        expect(current_path).to eq(login_path)

        expect(page).to have_content('Your credentials are incorrect.')
      end

      it '*cannot login with bad email' do
        user = create(:user)

        visit root_path

        click_link('Login')

        expect(current_path).to eq(login_path)
        fill_in('Email', with: 'wrong_email@gmail.com')
        fill_in('Password', with: user.password)
        click_button('Log In')

        expect(current_path).to eq(login_path)

        expect(page).to have_content('Your credentials are incorrect.')
      end
    end
  end

end
