require 'rails_helper'

RSpec.describe 'Items Index Page Statistics', type: :feature do
  before :each do
    @merchant = create(:merchant)
    @user = create(:user)

    @item_1 = create(:inactive_item)
    @item_2 = create(:item, quantity: 30)
    @item_3 = create(:item, quantity: 30)
    @item_4 = create(:item, quantity: 30)
    @item_5 = create(:item, quantity: 30)
    @item_6 = create(:item, quantity: 30)
    @item_7 = create(:item, quantity: 30)
    @item_8 = create(:item, quantity: 30)
    @item_9 = create(:item, quantity: 30)
    @item_10 = create(:item, quantity: 30)
    @item_11 = create(:item, quantity: 30)

    @order_1 = create(:order, user: @user)
    @order_2 = create(:shipped_order, user: @user)
    @order_3 = create(:shipped_order, user: @user)

    @order_item_1= create(:fulfilled_order_item, item: @item_1, order: @order_1)
    @order_item_2= create(:fulfilled_order_item, item: @item_2, order: @order_2, quantity: 20)
    @order_item_3= create(:fulfilled_order_item, item: @item_3, order: @order_2, quantity: 18 )
    @order_item_4= create(:fulfilled_order_item, item: @item_4, order: @order_2, quantity: 16 )
    @order_item_5= create(:fulfilled_order_item, item: @item_5, order: @order_2, quantity: 14 )
    @order_item_6= create(:fulfilled_order_item, item: @item_6, order: @order_2, quantity: 12 )
    @order_item_7= create(:fulfilled_order_item, item: @item_7, order: @order_3, quantity: 10 )
    @order_item_8= create(:fulfilled_order_item, item: @item_8, order: @order_3, quantity: 9 )
    @order_item_9= create(:fulfilled_order_item, item: @item_9, order: @order_3, quantity: 8 )
    @order_item_10= create(:fulfilled_order_item, item: @item_10, order: @order_3, quantity: 6 )
    @order_item_11= create(:fulfilled_order_item, item: @item_11, order: @order_3, quantity: 2 )
    @order_item_12= create(:fulfilled_order_item, item: @item_11, order: @order_3, quantity: 2 )

    visit items_path
  end

  context 'as any kind of user on the system' do
    it 'shows an area with statistics' do
      within "#statistics-container" do
        within "#popular-items" do
          expect(page).to have_content("5 Most Popular Items")
          expect(page).to have_content("#{@item_2.name}: 20")
          expect(page).to have_content("#{@item_3.name}: 18")
          expect(page).to have_content("#{@item_4.name}: 16")
          expect(page).to have_content("#{@item_5.name}: 14")
          expect(page).to have_content("#{@item_6.name}: 12")
        end
        within "#unpopular-items" do
          expect(page).to have_content("5 Least Popular Items")
          expect(page).to have_content("#{@item_11.name}: 4")
          expect(page).to have_content("#{@item_10.name}: 6")
          expect(page).to have_content("#{@item_9.name}: 8")
          expect(page).to have_content("#{@item_8.name}: 9")
          expect(page).to have_content("#{@item_7.name}: 10")
        end
      end
    end
  end
end
