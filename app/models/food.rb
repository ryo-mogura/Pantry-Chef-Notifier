# frozen_string_literal: true

class Food < ApplicationRecord
  belongs_to :user
  enum storage: { refrigerator: 0, freezer: 1, others: 2 }
end
