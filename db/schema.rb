# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_25_141723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badge_recos", force: :cascade do |t|
    t.bigint "badge_id", null: false
    t.bigint "recommendation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["badge_id"], name: "index_badge_recos_on_badge_id"
    t.index ["recommendation_id"], name: "index_badge_recos_on_recommendation_id"
  end

  create_table "badges", force: :cascade do |t|
    t.text "picto"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "phone_number"
    t.text "doctolib_url"
    t.string "specialty"
    t.string "convention"
    t.string "profession"
    t.integer "average_number"
    t.string "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_favorites_on_doctor_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "friend_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_recommendations_on_doctor_id"
    t.index ["user_id"], name: "index_recommendations_on_user_id"
  end

  create_table "tag_recos", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "recommendation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recommendation_id"], name: "index_tag_recos_on_recommendation_id"
    t.index ["tag_id"], name: "index_tag_recos_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.text "picto"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "phone_number"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "badge_recos", "badges"
  add_foreign_key "badge_recos", "recommendations"
  add_foreign_key "favorites", "doctors"
  add_foreign_key "favorites", "users"
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "recommendations", "doctors"
  add_foreign_key "recommendations", "users"
  add_foreign_key "tag_recos", "recommendations"
  add_foreign_key "tag_recos", "tags"
end
