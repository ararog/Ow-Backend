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

ActiveRecord::Schema.define(version: 20140916222049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "connections", id: false, force: true do |t|
    t.string  "id"
    t.integer "user_id"
  end

  create_table "contacts", force: true do |t|
    t.integer "user_id"
    t.integer "person_id"
    t.string  "first_name", limit: 100
    t.string  "last_name",  limit: 100
  end

  create_table "notifications", force: true do |t|
    t.integer "type"
    t.string  "content"
    t.integer "contact_id"
  end

  create_table "peers", force: true do |t|
    t.integer "user_id"
    t.string  "address"
  end

  create_table "users", force: true do |t|
    t.string "phone_number", limit: 30
    t.string "first_name",   limit: 100
    t.string "last_name",    limit: 100
    t.string "country_code", limit: 10
    t.string "status",       limit: 1
  end

  add_foreign_key "contacts", "users", name: "contacts_person_id_fk", column: "person_id"
  add_foreign_key "contacts", "users", name: "contacts_user_id_fk"

  add_foreign_key "notifications", "contacts", name: "notifications_contact_id_fk"

  add_foreign_key "peers", "users", name: "peers_user_id_fk"

end
