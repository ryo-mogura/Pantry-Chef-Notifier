# frozen_string_literal: true

class Food < ApplicationRecord
  belongs_to :user
  enum storage: { refrigerator: 0, freezer: 1, others: 2 }

  validates :name, presence: true
  validates :expiration_date, presence: true
  validates :storage, presence: true
  validates :quantity, numericality: { only_integer: true }, presence: true
  # Ransackv4.0.0で追加された許可リストの作成
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at expiration_date name quantity storage updated_at]
  end
end
