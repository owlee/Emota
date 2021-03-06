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

ActiveRecord::Schema.define(version: 20170316152514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.string   "name"
    t.decimal  "duration"
    t.text     "mood"
    t.text     "deviations"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emota", force: :cascade do |t|
    t.integer  "emotion_id"
    t.decimal  "image_processing_time"
    t.decimal  "api_roundtrip_time"
    t.decimal  "score_logging_time"
    t.boolean  "has_valid_face",        default: false
    t.text     "notes"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "emota", ["emotion_id"], name: "index_emota_on_emotion_id", using: :btree

  create_table "emotions", force: :cascade do |t|
    t.decimal  "surprise"
    t.decimal  "anger"
    t.decimal  "contempt"
    t.decimal  "disgust"
    t.decimal  "fear"
    t.decimal  "happiness"
    t.decimal  "neutral"
    t.decimal  "sadness"
    t.decimal  "surprise_p"
    t.decimal  "anger_p"
    t.decimal  "contempt_p"
    t.decimal  "disgust_p"
    t.decimal  "fear_p"
    t.decimal  "happiness_p"
    t.decimal  "neutral_p"
    t.decimal  "sadness_p"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
