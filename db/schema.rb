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

ActiveRecord::Schema[7.1].define(version: 2024_03_02_182910) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "couple_challenges", force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.integer "difficulty"
    t.integer "estimated_time"
    t.string "prompt_1"
    t.string "prompt_2"
    t.integer "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "couple_tasks", force: :cascade do |t|
    t.bigint "couple_challenge_id", null: false
    t.bigint "couple_id", null: false
    t.date "completion_date"
    t.boolean "active"
    t.boolean "completed"
    t.string "date_option_1"
    t.date "date_option_2"
    t.date "date_option_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["couple_challenge_id"], name: "index_couple_tasks_on_couple_challenge_id"
    t.index ["couple_id"], name: "index_couple_tasks_on_couple_id"
  end

  create_table "couples", force: :cascade do |t|
    t.bigint "partner_1_id", null: false
    t.bigint "partner_2_id", null: false
    t.date "relation_since"
    t.integer "total_exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_1_id"], name: "index_couples_on_partner_1_id"
    t.index ["partner_2_id"], name: "index_couples_on_partner_2_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "details"
    t.string "location"
    t.date "date"
    t.bigint "couple_id", null: false
    t.boolean "is_memory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["couple_id"], name: "index_events_on_couple_id"
  end

  create_table "fortunes", force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "individual_challenges", force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.integer "estimated_time"
    t.integer "difficulty"
    t.string "prompt"
    t.integer "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "individual_tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "individual_challenge_id", null: false
    t.boolean "active"
    t.boolean "completed"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["individual_challenge_id"], name: "index_individual_tasks_on_individual_challenge_id"
    t.index ["user_id"], name: "index_individual_tasks_on_user_id"
  end

  create_table "love_languages", force: :cascade do |t|
    t.integer "acts_of_service"
    t.integer "words_of_affirmation"
    t.integer "receiving_gifts"
    t.integer "quality_time"
    t.integer "physical_touch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "missions", force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.string "icon"
    t.integer "exp"
    t.bigint "user_id", null: false
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_missions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "gender"
    t.date "date_of_birth"
    t.bigint "love_language_id", null: false
    t.string "avatar_url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["love_language_id"], name: "index_users_on_love_language_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "couple_tasks", "couple_challenges"
  add_foreign_key "couple_tasks", "couples"
  add_foreign_key "couples", "users", column: "partner_1_id"
  add_foreign_key "couples", "users", column: "partner_2_id"
  add_foreign_key "events", "couples"
  add_foreign_key "individual_tasks", "individual_challenges"
  add_foreign_key "individual_tasks", "users"
  add_foreign_key "missions", "users"
  add_foreign_key "users", "love_languages"
end
