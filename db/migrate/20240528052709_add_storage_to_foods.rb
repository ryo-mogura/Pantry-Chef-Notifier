# frozen_string_literal: true

class AddStorageToFoods < ActiveRecord::Migration[7.1]
  def change
    add_column :foods, :storage, :integer, null: false, default: 0
  end
end
