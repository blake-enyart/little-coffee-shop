require 'rails_helper'

RSpec.describe 'merchants index page' do
  context 'as an admin' do
    before(:each) do
      @admin = create(:admin)
      @merchant = create(:merchant)
      @item_list = create_list(:item, 3)
      @merchant.items << @item_list

      allow_any_instance_of(ApplicationController).to \
      receive(:current_user).and_return(@admin)
    end

    it 'can downgrade the role of a merchant' do
      visit admin_merchant_path(@merchant)
      click_button 'Downgrade to User'

      expect(page).to have_content("Merchant #{@merchant.name} downgraded.")
      expect(current_path).to eq(admin_user_path(@merchant.id))

      visit items_path

      expect(page).to_not have_content(@item_list[0].name)
      expect(page).to_not have_content(@item_list[1].name)
      expect(page).to_not have_content(@item_list[2].name)
    end

    it 'can upgrade the role of a user' do
      user = create(:user)

      visit admin_user_path(user)
      click_button 'Upgrade to Merchant'

      expect(page).to have_content("User #{user.name} upgraded to merchant.")
      expect(current_path).to eq(admin_merchant_path(user.id))
    end

    it "visiting user at merchant show URI redirects" do
      user = create(:user)

      visit admin_merchant_path(user)

      expect(current_path).to eq(admin_user_path(user))
    end

    it 'displays correct data of all non admin/merchant users' do
      user_1 = create(:user)
      user_2 = create(:user)

      visit root_path
      click_on 'Users'

      expect(current_path).to eq(admin_users_path)

      expect(page).to have_link(user_1.name)
      expect(page).to have_content(user_1.created_at)

      expect(page).to have_link(user_2.name)
      expect(page).to have_content(user_2.created_at)

      expect(page).to_not have_link(@merchant.name)
    end
  end
end
