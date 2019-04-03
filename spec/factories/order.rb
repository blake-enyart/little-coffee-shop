FactoryBot.define do
  factory :order, class: Order do
    user
    status { 0 }
  end
  factory :packaged_order, parent: :order do
    user
    status { 1 }
  end
  factory :shipped_order, parent: :order do
    user
    status { 2 }
  end
  factory :cancelled_order, parent: :order do
    user
    status { 3 }
  end
end
