FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test_#{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password              { "111111" }
    password_confirmation { "111111" }
  end
end
