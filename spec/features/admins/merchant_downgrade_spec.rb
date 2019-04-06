require 'rails_helper'

RSpec.describe 'role downgrade' do
  it 'admin-users can downgrade the role of merchants' do

    admin = create(:admin)
    merchant = create(:merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit "/admin/merchants/#{merchant.id}"
    click_on 'downgrade to user'
    expect(current_path).to eq(admin_user_path(merchant.id))
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
    visit "/admin/merchants/#{merchant.id}"
    expect(page).to have_http_status(404)
  end

  it 'should disble all of the merchants items upon downgrading them' do
    admin = create(:admin)
    merchant = create(:merchant)
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)
    merchant.items << item_1
    merchant.items << item_2
    merchant.items << item_3
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    expect(item_1.enabled).to eq(true)
    expect(item_2.enabled).to eq(true)
    expect(item_3.enabled).to eq(true)
    visit "/admin/merchants/#{merchant.id}"
    click_on 'downgrade to user'
    expect(page).to have_content("Merchant downgraded")
    expect(merchant.items[0].enabled).to eq(false)
    expect(merchant.items[1].enabled).to eq(false)
    expect(merchant.items[2].enabled).to eq(false)
  end
end
