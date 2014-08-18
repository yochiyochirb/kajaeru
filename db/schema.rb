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

ActiveRecord::Schema.define(version: 20140818173520) do

  create_table "members", force: true do |t|
    t.string   "nickname",   null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "image",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["nickname", "uid", "image"], name: "index_members_on_nickname_and_uid_and_image", unique: true
  add_index "members", ["uid"], name: "index_members_on_uid", unique: true

  create_table "votes", force: true do |t|
    t.text     "comment"
    t.integer  "voted_member_id",  null: false
    t.integer  "voting_member_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voting_member_id"], name: "index_votes_on_voting_member_id", unique: true

end
