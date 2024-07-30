class CreateFoodImages < ActiveRecord::Migration[7.1]
  def change
    create_table :food_images do |t|
      t.string :image_url, null: false

      t.timestamps
    end

    add_reference :foods, :food_image, foreign_key: true
  end
end
