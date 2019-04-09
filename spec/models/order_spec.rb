require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :status }
  end

  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many :order_items }
    it { should have_many(:items).through(:order_items) }
  end

  describe 'Instance Method(s)' do
    it '#total_quantity' do
      oi_1 = create(:order_item)
      #creates three order_items and items bound to same order from oi_1
      oi_2, oi_3, oi_4 = create_list(:order_item, 3, order: oi_1.order)
      #main order for clarity in test
      order_1 = oi_1.order

      #total quantity of items in a single order
      actual = order_1.total_quantity
      #generated via pry session AR query
      expected = [oi_1, oi_2, oi_3, oi_4].sum { |oi| oi.quantity }

      expect(actual).to eq(expected)
    end

    it '#grand_total' do
      oi_1 = create(:order_item)
      #creates three order_items and items bound to same order from oi_1
      oi_2, oi_3, oi_4 = create_list(:order_item, 3, order: oi_1.order)
      #main order for clarity in test
      order_1 = oi_1.order

      #grand total of item prices summed up for single order
      actual = order_1.grand_total
      #generated via pry session AR query
      expected = [oi_1, oi_2, oi_3, oi_4].sum { |oi| oi.quantity * oi.order_price }

      expect(actual).to eq(expected)
    end
  end
end
