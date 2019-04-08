require 'rails_helper'

RSpec.describe 'Dashboard Show Page' do
  context '*as a merchant user' do
    describe '*happy path' do
      before(:each) do
        @merchant = create(:merchant)

        visit root_path

        click_link "Login"

        expect(current_path).to eq(login_path)
        fill_in "email", with: @merchant.email
        fill_in "password", with: @merchant.password
        click_button "Log In"
      end

      it '*can see all the appropriate user data on profile' do

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content(@merchant.name)
        expect(page).to have_content("Email: #{@merchant.email}")
        expect(page).to have_content(@merchant.street)
        expect(page).to have_content("#{@merchant.city}, #{@merchant.state} #{@merchant.zipcode}")
        expect(page).to_not have_content(@merchant.password)
        expect(page).to_not have_link('Edit Details')
      end
    end
  end
end
