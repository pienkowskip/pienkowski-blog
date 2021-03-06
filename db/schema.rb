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

ActiveRecord::Schema.define(version: 20140525173901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string "text_id", null: false
    t.string "name",    null: false
  end

  add_index "categories", ["text_id"], name: "index_categories_on_text_id", unique: true, using: :btree

  create_table "directories", force: true do |t|
    t.string "ancestry"
    t.text   "fullpath", null: false
    t.string "name",     null: false
  end

  add_index "directories", ["name", "ancestry"], name: "index_directories_on_name_and_ancestry", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.integer  "category_id",    null: false
    t.integer  "author_id",      null: false
    t.string   "title",          null: false
    t.text     "content",        null: false
    t.text     "parsed_content", null: false
    t.text     "parsed_excerpt"
    t.datetime "created_at",     null: false
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree
  add_index "posts", ["category_id"], name: "index_posts_on_category_id", using: :btree

  create_table "resources", force: true do |t|
    t.integer  "directory_id", null: false
    t.string   "name",         null: false
    t.string   "type",         null: false
    t.string   "title"
    t.datetime "created_at",   null: false
    t.binary   "content",      null: false
  end

  create_table "users", force: true do |t|
    t.string   "username",                     null: false
    t.string   "email",                        null: false
    t.string   "crypted_password",             null: false
    t.string   "salt",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
