require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
    it { should validate_presence_of :role }

    it { should validate_uniqueness_of :email }
  end

  describe 'Relationships' do
    it { should have_many :orders } # for customers
    it { should have_many :items } # for merchants
  end
end
