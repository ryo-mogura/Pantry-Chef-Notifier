class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.string :image_url, null: false
      t.string :image_name, null: false

      t.timestamps
    end

    add_reference :foods, :image, foreign_key: true
  end
end
