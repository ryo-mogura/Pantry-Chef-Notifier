# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_30_131026) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.date "expiration_date"
    t.integer "quantity"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "storage", default: 0, null: false
    t.string "food_image"
    t.integer "category_id"
    t.bigint "image_id"
    t.index ["image_id"], name: "index_foods_on_image_id"
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "image_url", null: false
    t.string "image_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_messages", force: :cascade do |t|
    t.string "temp_name"
    t.string "temp_quantity"
    t.string "temp_expiration_date"
    t.string "temp_storage"
    t.string "temp_image"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "temp_category_id"
    t.index ["user_id"], name: "index_line_messages_on_user_id"
  end

  create_table "rakuten_recipes", force: :cascade do |t|
    t.string "title"
    t.string "indication"
    t.string "cost"
    t.string "image_url"
    t.string "recipe_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rakuten_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "provider"
    t.string "uid"
    t.integer "status", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "foods", "images"
  add_foreign_key "foods", "users"
  add_foreign_key "line_messages", "users"
  add_foreign_key "rakuten_recipes", "users"
end
