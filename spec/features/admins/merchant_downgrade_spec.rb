require 'rails_helper'
###  Add comnfirmation of content appearing on page
RSpec.describe 'role downgrade' do
  context 'as an admin' do
    it 'admin-users can downgrade the role of merchants' do

      admin = create(:admin)
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit "/admin/merchants/#{merchant.id}"
      click_on 'downgrade to user'
      expect(page).to have_content("Merchant downgraded")
      expect(current_path).to eq(admin_user_path(merchant.id))
      # expect(page).to have_link('Cart')
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      # visit "/admin/merchants/#{merchant.id}"
      # expect(page).to have_http_status(404)
    end
  end
end
