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

ActiveRecord::Schema.define(version: 2020_04_02_124453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "likes", force: :cascade do |t|
    t.integer "likee_id"
    t.integer "liker_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "user1_id"
    t.integer "user2_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sun_signs", force: :cascade do |t|
    t.string "name"
    t.text "wish"
    t.text "hates"
    t.text "bad_traits"
    t.text "good_traits"
    t.text "favorites"
    t.text "planet"
    t.string "symbol"
    t.text "keywords"
    t.string "vibe"
    t.text "compatability"
    t.text "mental_traits"
    t.text "physical_traits"
    t.text "sun_dates"
    t.string "element"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "firstName"
    t.string "lastName"
    t.string "location"
    t.integer "age"
    t.string "birthDate"
    t.string "picture"
    t.string "gender"
    t.string "lookingFor"
    t.integer "sun_sign_id"
    t.text "bioIntro"
    t.text "bioGeneral"
    t.text "bioFood"
    t.text "bioMusic"
    t.text "bioMovies"
    t.text "bioBooks"
    t.text "bioActivities"
    t.text "bioGoals"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
