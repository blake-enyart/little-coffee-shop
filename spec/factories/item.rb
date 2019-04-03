FactoryBot.define do
  factory :item do
    association :user, factory: :merchant
    sequence(:name) { |n| "Item Name #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:image_url) { |n| "https://picsum.photos/200/300?image=#{n}" }
    sequence(:price) { |n| ("#{n}".to_i+1)*1.5 }
    sequence(:quantity) { |n| ("#{n}".to_i+1)*2 }
    enabled { true }
  end

  factory :inactive_item, parent: :item do
    association :user, factory: :merchant
    sequence(:name) { |n| "Inactive Item Name #{n}" }
    enabled { false }
  end
end
