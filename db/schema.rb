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

ActiveRecord::Schema.define(version: 20150122225308) do

  create_table "articles", force: true do |t|
    t.string   "title",                        null: false
    t.text     "content",                      null: false
    t.string   "author"
    t.integer  "ip",                           null: false
    t.float    "rating",         default: 0.0
    t.date     "date"
    t.integer  "category_id"
    t.integer  "count_comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version",   default: 0
  end

  add_index "articles", ["rating", "category_id", "count_comments", "author"], name: "rating_category_comments_author", using: :btree

  create_table "categories", force: true do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "content",                null: false
    t.integer  "article_id",             null: false
    t.integer  "rating",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["rating", "article_id"], name: "rating_article", using: :btree

end
