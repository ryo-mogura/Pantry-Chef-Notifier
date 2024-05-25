# frozen_string_literal: true

class AddNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false
  end
end
