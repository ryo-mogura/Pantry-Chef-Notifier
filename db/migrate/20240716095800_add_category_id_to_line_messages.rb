class AddCategoryIdToLineMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :line_messages, :temp_category_id, :string
  end
end
