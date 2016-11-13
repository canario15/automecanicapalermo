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

ActiveRecord::Schema.define(version: 20161111191620) do

  create_table "budgets", force: :cascade do |t|
    t.integer  "work_order_id"
    t.integer  "total"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "budgets", ["work_order_id"], name: "index_budgets_on_work_order_id"

  create_table "customers", force: :cascade do |t|
    t.string "owner"
    t.string "invoice_name"
    t.string "rut"
    t.string "phone"
    t.string "address"
    t.string "email"
  end

  create_table "replacements", force: :cascade do |t|
    t.string  "name"
    t.string  "price"
    t.integer "work_order_id"
  end

  add_index "replacements", ["work_order_id"], name: "index_replacements_on_work_order_id"

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "user_type"
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "brand"
    t.string   "model"
    t.string   "displacement"
    t.string   "year"
    t.string   "plate"
    t.string   "color"
    t.string   "chassis_number"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "active",         default: true
  end

  create_table "work_dones", force: :cascade do |t|
    t.integer  "work_order_id"
    t.string   "work"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "work_dones", ["work_order_id"], name: "index_work_dones_on_work_order_id"

  create_table "work_ins", force: :cascade do |t|
    t.integer "work_order_id"
    t.string  "work"
    t.boolean "done"
  end

  add_index "work_ins", ["work_order_id"], name: "index_work_ins_on_work_order_id"

  create_table "work_orders", force: :cascade do |t|
    t.date     "date_in"
    t.integer  "number"
    t.integer  "customer_id"
    t.integer  "vehicle_id"
    t.string   "km"
    t.string   "fuel"
    t.text     "coments"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "status"
  end

  add_index "work_orders", ["customer_id"], name: "index_work_orders_on_customer_id"
  add_index "work_orders", ["user_id"], name: "index_work_orders_on_user_id"
  add_index "work_orders", ["vehicle_id"], name: "index_work_orders_on_vehicle_id"

end
