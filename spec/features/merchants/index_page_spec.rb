require 'rails_helper'

RSpec.describe "All users can see a merchants index page", type: :feature do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:inactive_merchant)

    visit merchants_path

    
  end
end
