require 'rails_helper'

RSpec.describe 'Items Index Page', type: :feature do
  before :each do
    @merchant = create(:merchant)
    @user = create(:user)

    @item_1 = create(:item)
    @item_2 = create(:item)
    @item_3 = create(:item)
    @item_4 = create(:item)
    @item_5 = create(:item)
    @item_6 = create(:item)
    @item_7 = create(:item)
    @item_8 = create(:item)
    @item_9 = create(:item)
    @item_10 = create(:item)
    @item_11 = create(:item)

    @order_1 = create(:shipped_order, user: @user)
    @order_2 = create(:shipped_order, user: @user)
    @order_3 = create(:shipped_order, user: @user)

    @order_item_1= create(:fulfilled_order_item, item: @item_1, order: @order_1)
    @order_item_2= create(:fulfilled_order_item, item: @item_1, order: @order_2)
    @order_item_3= create(:fulfilled_order_item, item: @item_1, order: @order_3)
    @order_item_3= create(:fulfilled_order_item, item: @item_1, order: @order_3)
    @order_item_3= create(:fulfilled_order_item, item: @item_1, order: @order_3)
    @order_item_3= create(:fulfilled_order_item, item: @item_1, order: @order_3)
    @order_item_3= create(:fulfilled_order_item, item: @item_1, order: @order_3)
    @order_item_3= create(:fulfilled_order_item, item: @item_1, order: @order_3)
    @order_item_3= create(:fulfilled_order_item, item: @item_1, order: @order_3)
    @order_item_3= create(:fulfilled_order_item, item: @item_1, order: @order_3)
    @order_item_3= create(:fulfilled_order_item, item: @item_1, order: @order_3)
    @order_item_3= create(:fulfilled_order_item, item: @item_1, order: @order_3)

    visit items_path
  end

  context 'as any kind of user on the system' do
    describe 'they can see an area with statistics' do
      it 'shows the top 5 most popular items by quantity purchased'

      end

      it 'shows the bottom 5 least popular items by quantity purchased'

      end
    end
  end
end
