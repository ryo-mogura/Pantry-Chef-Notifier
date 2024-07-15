class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '野菜' },
    { id: 2, name: '果物' },
    { id: 3, name: '水産物・水産加工品' },
    { id: 4, name: '肉・肉加工品' },
    { id: 5, name: '卵・チーズ・乳製品' },
    { id: 6, name: '麺類' },
    { id: 7, name: '粉類' },
    { id: 8, name: '飲料' },
    { id: 9, name: '菓子類' },
    { id: 10, name: '調味料' },
    { id: 11, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :foods
end
