FactoryBot.define do
  factory :image do
    image_url {  File.open(Rails.root.join('spec/fixtures/images/test.jpg'))} # 適当な画像URLを指定
    image_name { "テスト初期データ画像" } # 適当な名前を指定
  end
end
