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

ActiveRecord::Schema[8.1].define(version: 2026_03_30_210109) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bands", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "owner_id", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_bands_on_owner_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.datetime "accepted_at"
    t.bigint "band_id", null: false
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "token", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_invitations_on_band_id"
    t.index ["token"], name: "index_invitations_on_token", unique: true
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.datetime "created_at", null: false
    t.string "role", default: "member", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["band_id"], name: "index_memberships_on_band_id"
    t.index ["user_id", "band_id"], name: "index_memberships_on_user_id_and_band_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "setlist_items", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "duration_seconds"
    t.string "item_type", null: false
    t.integer "position"
    t.bigint "setlist_id", null: false
    t.bigint "song_id"
    t.datetime "updated_at", null: false
    t.index ["setlist_id", "position"], name: "index_setlist_items_on_setlist_id_and_position"
    t.index ["setlist_id"], name: "index_setlist_items_on_setlist_id"
    t.index ["song_id"], name: "index_setlist_items_on_song_id"
  end

  create_table "setlist_song_notes", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.bigint "setlist_id", null: false
    t.bigint "song_id", null: false
    t.datetime "updated_at", null: false
    t.index ["setlist_id", "song_id"], name: "index_setlist_song_notes_on_setlist_id_and_song_id", unique: true
    t.index ["setlist_id"], name: "index_setlist_song_notes_on_setlist_id"
    t.index ["song_id"], name: "index_setlist_song_notes_on_song_id"
  end

  create_table "setlists", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_setlists_on_band_id"
  end

  create_table "songs", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.datetime "created_at", null: false
    t.integer "duration_seconds"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_songs_on_band_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bands", "users", column: "owner_id"
  add_foreign_key "invitations", "bands"
  add_foreign_key "memberships", "bands"
  add_foreign_key "memberships", "users"
  add_foreign_key "setlist_items", "setlists"
  add_foreign_key "setlist_items", "songs"
  add_foreign_key "setlist_song_notes", "setlists"
  add_foreign_key "setlist_song_notes", "songs"
  add_foreign_key "setlists", "bands"
  add_foreign_key "songs", "bands"
end
