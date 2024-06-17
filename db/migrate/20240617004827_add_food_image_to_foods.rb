class AddFoodImageToFoods < ActiveRecord::Migration[7.1]
  def change
    add_column :foods, :food_image, :string
  end
end
