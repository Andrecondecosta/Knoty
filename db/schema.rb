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

ActiveRecord::Schema[7.1].define(version: 2024_03_21_234649) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "couple_id", null: false
    t.index ["couple_id"], name: "index_chatrooms_on_couple_id"
  end

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
    t.string "img_url"
  end

  create_table "couple_tasks", force: :cascade do |t|
    t.bigint "couple_challenge_id", null: false
    t.bigint "couple_id", null: false
    t.date "completion_date"
    t.boolean "active"
    t.boolean "completed"
    t.date "date_option_2"
    t.date "date_option_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_option_1"
    t.bigint "invited_id", null: false
    t.index ["couple_challenge_id"], name: "index_couple_tasks_on_couple_challenge_id"
    t.index ["couple_id"], name: "index_couple_tasks_on_couple_id"
    t.index ["invited_id"], name: "index_couple_tasks_on_invited_id"
  end

  create_table "couples", force: :cascade do |t|
    t.bigint "partner_1_id", null: false
    t.bigint "partner_2_id", null: false
    t.date "relation_since"
    t.integer "total_exp", default: 0
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
    t.bigint "user_id", null: false
    t.index ["couple_id"], name: "index_events_on_couple_id"
    t.index ["user_id"], name: "index_events_on_user_id"
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
    t.boolean "acts_of_service", default: false
    t.boolean "words_of_affirmation", default: false
    t.boolean "physical_touch", default: false
    t.boolean "quality_time", default: false
    t.boolean "receiving_gifts", default: false
    t.string "img_url"
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
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_love_languages_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
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

  create_table "noticed_events", force: :cascade do |t|
    t.string "type"
    t.string "record_type"
    t.bigint "record_id"
    t.jsonb "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notifications_count"
    t.index ["record_type", "record_id"], name: "index_noticed_events_on_record"
  end

  create_table "noticed_notifications", force: :cascade do |t|
    t.string "type"
    t.bigint "event_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.datetime "read_at", precision: nil
    t.datetime "seen_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_noticed_notifications_on_event_id"
    t.index ["recipient_type", "recipient_id"], name: "index_noticed_notifications_on_recipient"
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
    t.string "avatar_url"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.integer "mission_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chatrooms", "couples"
  add_foreign_key "couple_tasks", "couple_challenges"
  add_foreign_key "couple_tasks", "couples"
  add_foreign_key "couple_tasks", "users", column: "invited_id"
  add_foreign_key "couples", "users", column: "partner_1_id"
  add_foreign_key "couples", "users", column: "partner_2_id"
  add_foreign_key "events", "couples"
  add_foreign_key "events", "users"
  add_foreign_key "individual_tasks", "individual_challenges"
  add_foreign_key "individual_tasks", "users"
  add_foreign_key "love_languages", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "missions", "users"
end
