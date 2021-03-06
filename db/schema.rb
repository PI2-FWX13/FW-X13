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

ActiveRecord::Schema.define(version: 20171130202248) do

  create_table "conection_informations", force: :cascade do |t|
    t.string "name"
    t.string "ip"
    t.string "wifi_name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machine_settings", force: :cascade do |t|
    t.integer "maximum_offset"
    t.integer "maximum_size_mandril"
    t.integer "maximum_size_radius"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "conection_information_id"
    t.index ["conection_information_id"], name: "index_machine_settings_on_conection_information_id"
  end

  create_table "mandrils", force: :cascade do |t|
    t.float "compriment"
    t.float "radius"
    t.string "mandril_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "windings", force: :cascade do |t|
    t.string "project_name"
    t.float "length"
    t.float "radius"
    t.float "offset"
    t.float "filament_width"
    t.float "filament_length"
    t.float "gelPot"
    t.float "density"
    t.integer "layers"
    t.float "angle"
    t.time "winding_date"
    t.string "winding_type"
    t.time "estimated_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
