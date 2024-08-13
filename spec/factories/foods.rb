FactoryBot.define do
  factory :food do
    # sequence(:name) { |n| "テスト用の#{n}番目の食材名" }
    # sequence(:expiration_date) { |n| Date.today + n }
    sequence(:quantity) { |n| n }

    storage { 0 }
    association :user
  end
end
