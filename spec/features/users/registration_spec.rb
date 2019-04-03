require 'rails_helper'

RSpec.describe 'Registration workflow' do
  context '*as a unregistered visitor' do
    it '*it can register a user' do
      user = create(:user)

      visit root_path

      click_link 'Register'

      expect(current_path).to eq(new_user_path)
      fill_in "Name", with: user.name
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password_confirmation
      fill_in "Street", with: user.street
      fill_in "City", with: user.city
      fill_in "State", with: user.state
      fill_in "Zipcode", with: user.zipcode
      click_button "Register User"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You are now registered and logged in as #{user.email}.")
    end
  end
end
