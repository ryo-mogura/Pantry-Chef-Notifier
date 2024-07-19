class CreateRakutenRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :rakuten_recipes do |t|
      t.string :title
      t.string :indication
      t.string :cost
      t.string :image_url
      t.string :recipe_url
      t.references :user, null: false, foreign_key: true 

      t.timestamps
    end
  end
end
