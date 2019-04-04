require 'rails_helper'

RSpec.describe 'Profile Show Page' do
  describe '*happy path' do
    context '*as a registered user' do
      it '*can see all the appropriate user data' do

        user = create(:user)

        visit root_path

        click_link "Login"

        expect(current_path).to eq(login_path)
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        click_button "Log In"

        expect(current_path).to eq(profile_path)
        expect(page).to have_content(user.name)
        expect(page).to have_content("Email: #{user.email}")
        expect(page).to have_content("Address: #{user.street}")
        expect(page).to have_content("City: #{user.city}")
        expect(page).to have_content("State: #{user.state}")
        expect(page).to have_content("Zipcode: #{user.zipcode}")
        expect(page).to_not have_content(user.password)
        expect(page).to have_link('Edit Details')
      end
    end
  end
end
