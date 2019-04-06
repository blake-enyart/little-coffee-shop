require 'rails_helper'
###  Add comnfirmation of content appearing on page
RSpec.describe 'merchant role downgrade' do
  context 'as an admin' do
    it 'admin-users can downgrade the role of merchants' do
      admin = create(:admin)
      merchant = create(:merchant)
      item_1 = create(:item)
      item_2 = create(:item)
      item_3 = create(:item)
      merchant.items << item_1
      merchant.items << item_2
      merchant.items << item_3
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_merchant_path(merchant)
      click_on 'downgrade to user'
      expect(page).to have_content("Merchant #{merchant.name} downgraded")
      expect(current_path).to eq(admin_user_path(merchant.id))
      visit items_path
      expect(page).to_not have_content(item_1.name)
      expect(page).to_not have_content(item_2.name)
      expect(page).to_not have_content(item_3.name)
    end

    it 'when admin visits merchant that doesnt exist' do
      admin = create(:admin)
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_merchant_path(user)
      expect(current_path).to eq(admin_user_path(user))
    end
  end
end
