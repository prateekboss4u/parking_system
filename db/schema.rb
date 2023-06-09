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

ActiveRecord::Schema[7.0].define(version: 2023_05_02_090614) do
  create_table "billings", force: :cascade do |t|
    t.string "customer_name", null: false
    t.float "amount", null: false
    t.string "duration", null: false
    t.string "plate_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "subscription_id", null: false
    t.index ["subscription_id"], name: "index_billings_on_subscription_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "location_name"
    t.integer "two_wheeler_capacity"
    t.integer "four_wheeler_capacity"
    t.integer "commercial_vehicle_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.float "hourly_rate", null: false
    t.float "daily_pass", null: false
    t.float "weekly_pass", null: false
    t.float "monthly_pass", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location_id", null: false
    t.index ["location_id"], name: "index_rates_on_location_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "name", null: false
    t.string "type_of_pass", null: false
    t.string "plate_number", null: false
    t.datetime "start_date", precision: nil, null: false
    t.datetime "end_date", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rate_id"
    t.index ["rate_id"], name: "index_subscriptions_on_rate_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "type_of_user", null: false
    t.string "location", null: false
    t.string "city", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "billings", "subscriptions"
  add_foreign_key "locations", "users"
  add_foreign_key "rates", "locations"
  add_foreign_key "subscriptions", "rates"
end
