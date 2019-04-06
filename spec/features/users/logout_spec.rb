require 'rails_helper'

RSpec.describe 'Logout workflow' do
  describe '*happy path' do
    context '*as a logged user' do
      it '*can logout properly' do

        user = create(:user)

        visit root_path

        click_link('Login')
        fill_in('Email', with: user.email)
        fill_in('Password', with: user.password)
        click_button('Log In')

        expect(page).to have_content("You are now logged in as #{user.email}.")

        click_link('Logout')

        expect(current_path).to eq(root_path)
        expect(page).to have_content('You are now logged out')
        #Intended for testing when cart functionality complete
        # expect(page).to have_content('Cart: 0')
      end
    end

  end

end
