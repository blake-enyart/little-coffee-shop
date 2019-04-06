require 'rails_helper'

RSpec.describe 'Profile Show Page' do
  context '*as a registered user' do
    describe '*happy path' do
      before(:each) do
        @user = create(:user)

        visit root_path

        click_link "Login"

        expect(current_path).to eq(login_path)
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        click_button "Log In"
      end

      it '*can see all the appropriate user data on profile' do

        expect(current_path).to eq(profile_path)
        expect(page).to have_content(@user.name)
        expect(page).to have_content("Email: #{@user.email}")
        expect(page).to have_content(@user.street)
        expect(page).to have_content("#{@user.city}, #{@user.state} #{@user.zipcode}")
        expect(page).to_not have_content(@user.password)
        expect(page).to have_link('Edit Details')
      end

      it '*can edit single profile data attribute' do
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

      it '*can edit all profile data attributes' do
        new_info = build(:user)

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

        fill_in('Name', with: new_info.name)
        fill_in('Email', with: new_info.email)
        fill_in('Street', with: new_info.street)
        fill_in('City', with: new_info.street)
        fill_in('State', with: new_info.state)
        fill_in('Zipcode', with: new_info.zipcode)
        fill_in('Password', with: new_info.password)
        fill_in('Password confirmation', with: new_info.password)

        click_button('Submit')

        expect(current_path).to eq(profile_path)
        expect(page).to have_content('Your data is updated')
        expect(page).to have_content(new_info.name)
        expect(page).to have_content(new_info.email)
        expect(page).to have_content(new_info.street)
        expect(page).to have_content(new_info.state)
        expect(page).to have_content(new_info.zipcode)
        expect(page).to_not have_content(new_info.password)
      end

      it '*can edit all profile data except password' do
        new_info = build(:user)

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

        fill_in('Name', with: new_info.name)
        fill_in('Email', with: new_info.email)
        fill_in('Street', with: new_info.street)
        fill_in('City', with: new_info.street)
        fill_in('State', with: new_info.state)
        fill_in('Zipcode', with: new_info.zipcode)

        click_button('Submit')

        expect(current_path).to eq(profile_path)
        expect(page).to have_content('Your data is updated')
        expect(page).to have_content(new_info.name)
        expect(page).to have_content(new_info.email)
        expect(page).to have_content(new_info.street)
        expect(page).to have_content(new_info.state)
        expect(page).to have_content(new_info.zipcode)
        expect(page).to_not have_content(new_info.password)
      end

      it '*can change password correctly' do
        click_link('Edit Details')

        expect(current_path).to eq(edit_profile_path)
        expect(find_field('Password').value).to eq(nil)
        expect(find_field('Password confirmation').value).to eq(nil)

        fill_in('Password', with: 'new password')
        fill_in('Password confirmation', with: 'new password')
        click_button('Submit')

        expect(current_path).to eq(profile_path)
        expect(page).to have_content('Your data is updated')

        click_link('Logout')
        click_link('Login')

        fill_in('Email', with: @user.email)
        fill_in('Password', with: 'new password')
        click_button('Log In')

        expect(current_path).to eq(profile_path)
        expect(page).to have_content(@user.name)
      end
    end

    describe '*sad path' do
      before(:each) do
        @user = create(:user)

        visit root_path

        click_link "Login"

        expect(current_path).to eq(login_path)
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        click_button "Log In"
      end

      it '*user fills in mismatched passwords' do
        click_link('Edit Details')

        expect(current_path).to eq(edit_profile_path)
        expect(find_field('Password').value).to eq(nil)
        expect(find_field('Password confirmation').value).to eq(nil)

        fill_in('Password', with: 'new password')
        fill_in('Password confirmation', with: 'wrong password')
        click_button('Submit')

        expect(page).to have_content('Your passwords are mismatched')
        expect(page).to_not have_content('Your data is updated')

      end
    end
  end
end
