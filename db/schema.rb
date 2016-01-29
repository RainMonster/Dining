# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140304075936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "username"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "oauth_expires"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "credit_cards", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card_type"
    t.string   "last_4"
  end

  add_index "credit_cards", ["user_id"], name: "index_credit_cards_on_user_id", using: :btree

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.integer  "number_of_seats",                                   default: 8
    t.string   "neighborhood"
    t.string   "picture_of_dish"
    t.string   "region"
    t.string   "restaurant_name"
    t.text     "description"
    t.datetime "RSVP_deadline"
    t.datetime "event_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "available_seats",                                   default: true
    t.decimal  "amount",                    precision: 9, scale: 2, default: 1.0
    t.boolean  "rsvp_fee",                                          default: true
    t.boolean  "over",                                              default: false
    t.integer  "number_of_available_seats"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "reservations", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "transaction_number"
  end

  add_index "reservations", ["event_id"], name: "index_reservations_on_event_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "picture"
    t.string   "user_type",              default: "Normal User"
    t.string   "encrypted_password",     default: "",            null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "braintree_customer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
