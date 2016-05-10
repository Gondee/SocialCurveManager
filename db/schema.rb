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

ActiveRecord::Schema.define(version: 20160509175036) do

  create_table "clearing_houses", force: :cascade do |t|
    t.integer  "publisher_id"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "generatedlinks", force: :cascade do |t|
    t.string   "url"
    t.boolean  "paidout"
    t.datetime "date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.integer  "link_id"
    t.integer  "clicks"
    t.integer  "expire",     default: 10
    t.integer  "paidclicks", default: 0
    t.boolean  "dead",       default: false
  end

  create_table "links", force: :cascade do |t|
    t.string   "url"
    t.datetime "date"
    t.boolean  "used"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "publisher_id"
    t.float    "cpm"
    t.string   "title"
    t.string   "category"
    t.integer  "paidclicks"
  end

  create_table "paymentgroups", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "generatedlink_id"
    t.text     "note"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "company"
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "statistics", force: :cascade do |t|
    t.integer  "generatedlink_id"
    t.integer  "clicks"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "statsupdaters", force: :cascade do |t|
    t.text     "name"
    t.datetime "interval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.boolean  "expense"
    t.integer  "user_id"
    t.float    "amount"
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.string   "address"
    t.string   "phone"
    t.string   "url"
    t.text     "note"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "publisher"
    t.integer  "publisher_id"
    t.string   "paypal"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
