# frozen_string_literal: true

class CreateLineMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :line_messages do |t|
      t.string :temp_name
      t.string :temp_quantity
      t.string :temp_expiration_date
      t.string :temp_storage
      t.string :temp_image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
