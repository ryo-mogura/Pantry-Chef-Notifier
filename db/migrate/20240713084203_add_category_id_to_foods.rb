class AddCategoryIdToFoods < ActiveRecord::Migration[7.1]
  def change
    add_column :foods, :category_id, :integer
  end
end
