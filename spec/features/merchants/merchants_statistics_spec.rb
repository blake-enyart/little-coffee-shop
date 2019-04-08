require 'rails_helper'

RSpec.describe "All users can see a merchants index page", type: :feature do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:inactive_merchant)
  end

  context 'statistics section' do
    it 'can see top three merchants by price' do

      visit merchants_path

      within "#best-sellers}" do
        expect(page).to have_content("#{@merchant_1.name} : $")
        expect(page).to have_content("#{@merchant_2.name} : $")
        expect(page).to have_content("#{@merchant_3.name} : $")
      end
    end
  end
end