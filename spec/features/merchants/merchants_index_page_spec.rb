require 'rails_helper'

RSpec.describe "All users can see a merchants index page", type: :feature do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:inactive_merchant)
  end

  context 'as any kind of user on the system' do
    it 'shows all merchants in the system except disabled ones' do

      visit merchants_path

      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_link(@merchant_1.name, href: merchant_path(@merchant_1))
        expect(page).to have_content(@merchant_1.city)
        expect(page).to have_content(@merchant_1.state)
        expect(page).to have_content(@merchant_1.created_at)
      end

      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_link(@merchant_2.name, href: merchant_path(@merchant_2))
        expect(page).to have_content(@merchant_2.city)
        expect(page).to have_content(@merchant_2.state)
        expect(page).to have_content(@merchant_2.created_at)
      end

      expect(page).to_not have_css("#merchant-#{@merchant_3.id}")
    end
  end
end
