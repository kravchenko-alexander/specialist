# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170501125132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "providers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "type",       default: "", null: false
    t.string   "token",      default: "", null: false
    t.uuid     "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["type", "token", "user_id"], name: "providers_user_token_type", using: :btree
    t.index ["user_id"], name: "index_providers_on_user_id", using: :btree
  end

  create_table "sessions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer  "device_kind",              default: 0,                     null: false
    t.string   "access_token",                                             null: false
    t.string   "refresh_token",                                            null: false
    t.string   "push_token"
    t.uuid     "user_id",                                                  null: false
    t.uuid     "provider_id",                                              null: false
    t.datetime "access_token_expiration",  default: '2017-05-01 17:45:46', null: false
    t.datetime "refresh_token_expiration", default: '2017-05-01 17:45:46', null: false
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.index ["access_token_expiration", "access_token"], name: "sessions_access_token", using: :btree
    t.index ["provider_id"], name: "index_sessions_on_provider_id", using: :btree
    t.index ["refresh_token_expiration", "refresh_token"], name: "sessions_refresh_token", using: :btree
    t.index ["user_id", "access_token", "provider_id"], name: "sessions_user_token", using: :btree
    t.index ["user_id", "access_token", "refresh_token"], name: "sessions_user_tokens", using: :btree
    t.index ["user_id"], name: "index_sessions_on_user_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "email",           default: "", null: false
    t.string   "password_digest", default: "", null: false
    t.string   "first_name",      default: ""
    t.string   "last_name",       default: ""
    t.date     "birthday"
    t.integer  "gender"
    t.string   "secret_token",                 null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

end
