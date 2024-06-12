# frozen_string_literal: true

Food.create!([
               { name: '牛乳', expiration_date: '2024-05-29', storage: 0, quantity: 3, user_id: User.find(1).id },
               { name: '鶏肉', expiration_date: '2024-05-28', storage: 0, quantity: 2, user_id: User.find(1).id },
               { name: 'あじ', expiration_date: '2024-06-02', storage: 1, quantity: 5, user_id: User.find(1).id },
               { name: 'しめじ', expiration_date: '2024-06-13', storage: 0, quantity: 2, user_id: User.find(1).id },
               { name: '豚こま肉', expiration_date: '2024-06-30', storage: 1, quantity: 1, user_id: User.find(1).id },
               { name: 'りんご', expiration_date: '2024-06-30', storage: 2, quantity: 3, user_id: User.find(2).id },
               { name: 'みかん', expiration_date: '2024-06-02', storage: 2, quantity: 3, user_id: User.find(2).id },
               { name: 'カツオ', expiration_date: '2024-06-03', storage: 1, quantity: 3, user_id: User.find(2).id },
               { name: '車海老', expiration_date: '2024-06-02', storage: 1, quantity: 3, user_id: User.find(2).id }
             ])

20.times do
  Food.create!(
    name: Faker::Food.vegetables,
    expiration_date: Faker::Date.between(from: '2024-06-16', to: '2024-07-30'),
    storage: [0, 1, 2].sample,
    quantity: rand(1..10),
    user_id: User.find(1).id
  )
end
