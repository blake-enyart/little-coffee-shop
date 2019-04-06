require 'rails_helper'

RSpec.describe 'User views their cart show page with an EMPTY cart', type: :feature do
  context 'as an unregistered visitor and I view my cart with no items' do
    before :each do
      visit cart_path
    end

    it 'shows a message that my cart is empty' do
      expect(page).to have_content("Your cart is empty.")
    end

    scenario 'I do not see the link to empty my cart' do
      expect(page).to_not have_link("Empty Cart")
    end
  end

  context 'as an registered user (shopper) and I view my cart with no items' do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit cart_path
    end

    it 'shows a message that my cart is empty' do
      expect(page).to have_content("Your cart is empty.")
    end

    scenario 'I do not see the link to empty my cart' do
      expect(page).to_not have_link("Empty Cart")
    end
  end
end
