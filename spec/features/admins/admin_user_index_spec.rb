require 'rails_helper'
RSpec.describe 'admin user index' do
  context 'as an admin' do
    it 'users index should appear in nav' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit root_path
      expect(page).to have_link('Users')
    end
    it 'displays correct data of all non admin/merchant users' do
      admin = create(:admin)
      merchant = create(:merchant)
      user_1 = create(:user)
      user_2 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit root_path
      click_on 'Users'
      expect(current_path).to eq(admin_users_path)
      expect(page).to have_link(user_1.name)
      expect(page).to have_content(user_1.created_at)
      expect(page).to have_link("Upgrade #{user_1.name} to merchant")
      expect(page).to have_link(user_2.name)
      expect(page).to have_content(user_2.created_at)
      expect(page).to have_link("Upgrade #{user_2.name} to merchant")
    end
  end
  context 'as a merchant' do
    it 'users index should not appear in nav' do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      visit root_path
      expect(page).to_not have_link('users')
    end
  end
end
