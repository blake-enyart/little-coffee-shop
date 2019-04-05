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


end
