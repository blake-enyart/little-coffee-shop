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

      it '*when user is merchant, redirects to merchant show page' do
        admin = create(:admin)
        merchant = create(:merchant)
        allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(admin)

        visit admin_user_path(merchant)

        expect(current_path).to eq(admin_merchant_path(merchant))
      end
  end
end
