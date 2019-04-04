require 'rails_helper'

RSpec.describe 'Items Show Page', type: :feature do
  context 'as any visitor on the system' do
    describe "When they visit an item's show page from the items catalog" do
      before :each do
        @item_1 = create(:item)
        @item_2 = create(:item)
      end

      it "lets an unregistred visitor to see all information for this item" do
        visit item_path(@item_1)

        expect(page).to have_content(@item_1.name)
        expect(page).to have_content( "Description: #{@item_1.description}" )
        expect(page).to have_css("img[src*='#{@item_1.image_url}']")
        expect(page).to have_content( "Merchant: #{@item_1.user.name}" )
        expect(page).to have_content( "In stock: #{@item_1.quantity}" )
        expect(page).to have_content( "Unit Price: $#{@item_1.price.round(2)}" )
        expect(page).to have_content( "Average fulfillment time: #{@item_1.average_fulfilled_time}" )


        expect(page).to have_link("Add to Cart")
        expect(page).to_not have_content( "#{@item_2.name}" )
        expect(page).to_not have_content( "#{@item_2.description}" )
      end

      it "lets a registered user see all information for this item" do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit item_path(@item_1)

        expect(page).to have_content(@item_1.name)
        expect(page).to have_content( "Description: #{@item_1.description}" )
        expect(page).to have_css("img[src*='#{@item_1.image_url}']")
        expect(page).to have_content( "Merchant: #{@item_1.user.name}" )
        expect(page).to have_content( "In stock: #{@item_1.quantity}" )
        expect(page).to have_content( "Unit Price: $#{@item_1.price.round(2)}" )
        expect(page).to have_content( "Average fulfillment time: #{@item_1.average_fulfilled_time}" )

        expect(page).to have_link("Add to Cart")
        expect(page).to_not have_content( "#{@item_2.name}" )
        expect(page).to_not have_content( "#{@item_2.description}" )
      end

      it "lets a merchant see all information for this item" do
        merchant = create(:merchant)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit item_path(@item_1)

        expect(page).to have_content(@item_1.name)
        expect(page).to have_content( "Description: #{@item_1.description}" )
        expect(page).to have_css("img[src*='#{@item_1.image_url}']")
        expect(page).to have_content( "Merchant: #{@item_1.user.name}" )
        expect(page).to have_content( "In stock: #{@item_1.quantity}" )
        expect(page).to have_content( "Unit Price: $#{@item_1.price.round(2)}" )
        expect(page).to have_content( "Average fulfillment time: #{@item_1.average_fulfilled_time}" )

        expect(page).to_not have_content( "#{@item_2.name}" )
        expect(page).to_not have_content( "#{@item_2.description}" )
      end

      it "lets an admin see all information for this item" do
        admin = create(:admin)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit item_path(@item_1)

        expect(page).to have_content(@item_1.name)
        expect(page).to have_content( "Description: #{@item_1.description}" )
        expect(page).to have_css("img[src*='#{@item_1.image_url}']")
        expect(page).to have_content( "Merchant: #{@item_1.user.name}" )
        expect(page).to have_content( "In stock: #{@item_1.quantity}" )
        expect(page).to have_content( "Unit Price: $#{@item_1.price.round(2)}" )
        expect(page).to have_content( "Average fulfillment time: #{@item_1.average_fulfilled_time}" )

        expect(page).to_not have_content( "#{@item_2.name}" )
        expect(page).to_not have_content( "#{@item_2.description}" )
      end
    end
  end
end
