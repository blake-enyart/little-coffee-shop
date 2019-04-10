require 'rails_helper'

RSpec.describe 'Admin User Show Page', type: :feature do
  context 'as an admin' do
    describe '*visit a user show page' do
      it '*it displays all user information except edit' do
        admin = create(:admin)
        user_1 = create(:user)
        allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(admin)

        visit admin_users_path
        click_link(user_1.name)

        expect(page).to_not have_link('Edit Details', href: edit_profile_path)
      end
    end
    describe '*visit a users show page' do

      scenario 'admin clicks upgrade button' do
        admin = create(:admin)
        user_1 = create(:user)
        visit login_path
        fill_in "email", with: admin.email
        fill_in "password", with: admin.password
        click_button "Log In"
        visit admin_user_path(user_1)
        click_link 'Upgrade'

        expect(current_path).to eq(admin_merchant_path(user_1))

        user_1.reload

        expect(page).to have_content("#{user_1.name} has been upgraded")
        expect(user_1.role).to eq("merchant")

        click_on 'Logout'
        visit login_path
        fill_in "email", with: user_1.email
        fill_in "password", with: user_1.password
        click_button "Log In"
        visit dashboard_path

        expect(page).to have_http_status(200)
      end
    end
  end
end
