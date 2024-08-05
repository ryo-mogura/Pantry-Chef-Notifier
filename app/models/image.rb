class Image < ApplicationRecord
  has_many :foods

  # 画像アップロード用の設定
  mount_uploader :image_url, DefaultFoodImageUploader
end
