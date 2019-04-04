require 'rails_helper'

RSpec.describe 'Profile Show Page' do
  describe '*happy path' do
    context '*as a registered user' do
      before(:each) do
        @user = create(:user)

        visit root_path

        click_link "Login"

        expect(current_path).to eq(login_path)
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        click_button "Log In"
      end

      it '*can see all the appropriate user data' do

        expect(current_path).to eq(profile_path)
        expect(page).to have_content(@user.name)
        expect(page).to have_content("Email: #{@user.email}")
        expect(page).to have_content(@user.street)
        expect(page).to have_content("#{@user.city}, #{@user.state} #{@user.zipcode}")
        expect(page).to_not have_content(@user.password)
        expect(page).to have_link('Edit Details')
      end

      it '*can edit profile data' do
        click_link('Edit Details')

        expect(current_path).to eq(edit_profile_path)
        expect(find_field('Name').value).to eq(@user.name)
        expect(find_field('Email').value).to eq(@user.email)
        expect(find_field('Street').value).to eq(@user.street)
        expect(find_field('City').value).to eq(@user.city)
        expect(find_field('State').value).to eq(@user.state)
        expect(find_field('Zipcode').value).to eq(@user.zipcode)
        expect(find_field('Password').value).to eq(nil)
        expect(find_field('Password confirmation').value).to eq(nil)

        fill_in('Name', with: 'new name')
        
        click_button('Submit')
        expect(current_path).to eq(profile_path)
        expect(page).to have_content('Your data is updated')
        expect(page).to have_content('new name')
      end
    end

  end
end
