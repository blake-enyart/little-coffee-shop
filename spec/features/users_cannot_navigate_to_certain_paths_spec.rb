require 'rails_helper'

RSpec.describe 'Users cannot navigate to certain paths', type: :feature do
  context 'Unregistered Visitors' do
    it 'shows 404 error when visiting /profile paths' do
      visit profile_path
      expect(page).to have_http_status(404)
    end

    it 'shows 404 error when visiting /dashboard paths' do
      visit dashboard_path
      expect(page).to have_http_status(404)
    end

    it 'shows 404 error when visiting /admin paths' do
      admin = create(:admin)
      visit admin_dashboard_path(admin)
      expect(page).to have_http_status(404)
    end
  end

  context 'Registered users' do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it 'shows 404 error when visiting /dashboard paths' do
      visit dashboard_path
      expect(page).to have_http_status(404)
    end

    it 'shows 404 error when visiting /admin paths' do
      admin = create(:admin)
      visit admin_dashboard_path(admin)
      expect(page).to have_http_status(404)
    end
  end

  context 'Merchants' do
    before :each do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
    end

    it 'shows 404 error when visiting /profile paths' do
      visit profile_path
      expect(page).to have_http_status(404)
    end

    it 'shows 404 error when visiting /cart paths' do
      visit cart_path
      expect(page).to have_http_status(404)
    end

    it 'shows 404 error when visiting /admin paths' do
      admin = create(:admin)
      visit admin_dashboard_path(admin)
      expect(page).to have_http_status(404)
    end
  end

  context 'Admins' do
    before :each do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    it 'shows 404 error when visiting /profile paths' do
      visit profile_path
      expect(page).to have_http_status(404)
    end

    it 'shows 404 error when visiting /dashboard paths' do
      visit dashboard_path
      expect(page).to have_http_status(404)
    end

    it 'shows 404 error when visiting /cart paths' do
      visit cart_path
      expect(page).to have_http_status(404)
    end
  end
end
