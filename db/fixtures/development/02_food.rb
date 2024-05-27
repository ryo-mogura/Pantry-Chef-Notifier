Food.create!([
  { name: '牛乳', expiration_date: '2024-05-29', storage_location: '冷蔵庫', quantity: 3, user_id: User.find(1).id },
  { name: '鶏肉', expiration_date: '2024-05-28', storage_location: '冷蔵庫', quantity: 2, user_id: User.find(1).id },
  { name: 'あじ', expiration_date: '2024-06-02', storage_location: '冷凍庫', quantity: 5, user_id: User.find(1).id },
  { name: 'しめじ', expiration_date: '2024-06-13', storage_location: '冷蔵庫', quantity: 2, user_id: User.find(1).id },
  { name: '豚こま肉', expiration_date: '2024-06-30', storage_location: '冷凍庫', quantity: 1, user_id: User.find(1).id }
])
