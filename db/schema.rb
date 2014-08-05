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

ActiveRecord::Schema.define(version: 20140804175514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.text "body", null: false
    t.integer "user_id"
    t.integer "recording_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["recording_id"], name: "index_comments_on_recording_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "questions", force: true do |t|
    t.string "question"
    t.string "category"
  end

  create_table "recordings", force: true do |t|
    t.string "recording"
    t.integer "user_id"
    t.integer "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "public", default: true
  end

  add_index "recordings", ["question_id"], name: "index_recordings_on_question_id", using: :btree
  add_index "recordings", ["user_id"], name: "index_recordings_on_user_id", using: :btree

  create_table "user_questions", force: true do |t|
    t.integer "user_id"
    t.integer "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_questions", ["question_id"], name: "index_user_questions_on_question_id", using: :btree
  add_index "user_questions", ["user_id"], name: "index_user_questions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string "provider"
    t.string "uid"
    t.string "access_token"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
  end

end
