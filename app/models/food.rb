# frozen_string_literal: true

class Food < ApplicationRecord
  before_validation :sanitize_category_id

  belongs_to :user
  belongs_to :image, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  mount_uploader :food_image, FoodImageUploader
  enum storage: { refrigerator: 0, freezer: 1, others: 2 }

  validates :name, presence: true
  validates :expiration_date, presence: true
  validates :storage, presence: true
  validates :quantity, numericality: { only_integer: true }, presence: true
  validates :category_id, inclusion: { in: Category.all.map(&:id) }, allow_nil: true

  # Ransackv4.0.0で追加された許可リストの作成
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at expiration_date name quantity storage updated_at]
  end

  private
  # カテゴリIDが1〜11かをチェック、範囲外ならnilに設定
  def sanitize_category_id
    self.category_id = nil unless Category.all.map(&:id).include?(category_id)
  end

end
