require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :order_price }
    it { should validate_presence_of :quantity }
  end

  describe 'Relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end
end
