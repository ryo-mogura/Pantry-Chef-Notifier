
FoodImage.create!([
  { image_name: 'たまねぎ', image_url: File.open(Rails.root.join('db/fixtures/images/たまねぎ.jpg')) },
  { image_name: 'にんじん', image_url: File.open(Rails.root.join('db/fixtures/images/にんじん.jpg')) },
  { image_name: 'レタス', image_url: File.open(Rails.root.join('db/fixtures/images/レタス.jpg')) },
  { image_name: 'アスパラガス', image_url: File.open(Rails.root.join('db/fixtures/images/アスパラガス.jpg')) },
  { image_name: 'かぼちゃ', image_url: File.open(Rails.root.join('db/fixtures/images/かぼちゃ.jpg')) },
  { image_name: 'だいこん', image_url: File.open(Rails.root.join('db/fixtures/images/だいこん.jpg')) },
  { image_name: 'なす', image_url: File.open(Rails.root.join('db/fixtures/images/なす.jpg')) }
])
