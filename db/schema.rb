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

ActiveRecord::Schema.define(version: 20161223130405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "builds", force: :cascade do |t|
    t.integer "state",      default: 0
    t.string  "blob_file"
    t.string  "email"
    t.string  "gpg"
    t.integer "device_id"
    t.boolean "downloaded"
    t.json    "config"
    t.string  "uuid",                   null: false
    t.index ["device_id"], name: "index_builds_on_device_id", using: :btree
    t.index ["uuid"], name: "index_builds_on_uuid", unique: true, using: :btree
  end

  create_table "configurations", force: :cascade do |t|
    t.integer "build_id"
    t.integer "option_id"
    t.string  "value"
    t.index ["build_id"], name: "index_configurations_on_build_id", using: :btree
    t.index ["option_id"], name: "index_configurations_on_option_id", using: :btree
  end

  create_table "devices", force: :cascade do |t|
    t.string  "name"
    t.boolean "needs_rom_dump"
    t.integer "vendor_id"
    t.string  "codename"
    t.string  "commit"
    t.index ["vendor_id"], name: "index_devices_on_vendor_id", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "uuid",       null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_jobs_on_user_id", using: :btree
  end

  create_table "option_values", force: :cascade do |t|
    t.integer "option_id"
    t.string  "value"
    t.string  "enum_option"
    t.index ["option_id"], name: "index_option_values_on_option_id", using: :btree
  end

  create_table "options", force: :cascade do |t|
    t.string  "label"
    t.integer "device_id"
    t.string  "data_type"
    t.string  "default"
    t.string  "possible_values"
    t.integer "state",           default: 0
    t.index ["device_id"], name: "index_options_on_device_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      null: false
    t.string   "gpg",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
  end

end
