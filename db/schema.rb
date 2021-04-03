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

ActiveRecord::Schema.define(version: 2021_04_01_040344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.bigint "landlord_id", null: false
    t.string "name"
    t.float "price"
    t.string "description"
    t.string "street_address"
    t.string "city"
    t.string "postal_code"
    t.float "lat"
    t.float "lon"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "contact_email"
    t.string "contact_phone"
    t.integer "size"
    t.integer "num_bed"
    t.integer "num_bath"
    t.integer "bike_time"
    t.integer "walk_time"
    t.integer "drive_time"
    t.float "distance_to_campus"
    t.string "housing_type"
    t.boolean "featured", default: false
    t.boolean "available", default: true
    t.boolean "ac", default: false
    t.boolean "furnished", default: false
    t.boolean "gym", default: false
    t.boolean "laundry", default: false
    t.boolean "non_smoking", default: false
    t.boolean "parking", default: false
    t.boolean "pet_friendly", default: false
    t.boolean "study_room", default: false
    t.boolean "wifi", default: false
    t.string "image_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["landlord_id"], name: "index_listings_on_landlord_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "listings", "users", column: "landlord_id"
end
