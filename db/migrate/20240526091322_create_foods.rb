class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.date :expiration_date
      t.string :storage_location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
