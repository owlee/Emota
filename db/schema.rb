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

ActiveRecord::Schema.define(version: 20170227215717) do

  create_table "emota", force: :cascade do |t|
    t.integer  "emotion_id"
    t.string   "path"
    t.time     "on_server"
    t.time     "preprocess"
    t.time     "sent_api"
    t.time     "received_api"
    t.time     "stored_score"
    t.text     "notes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "emota", ["emotion_id"], name: "index_emota_on_emotion_id"

  create_table "emotions", force: :cascade do |t|
    t.decimal  "surprise"
    t.decimal  "anger"
    t.decimal  "contempt"
    t.decimal  "disgust"
    t.decimal  "fear"
    t.decimal  "happiness"
    t.decimal  "neutral"
    t.decimal  "sadness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
