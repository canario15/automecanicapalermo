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

ActiveRecord::Schema.define(version: 20170427184406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "box_movements", force: :cascade do |t|
    t.datetime "date"
    t.string   "cost_center"
    t.string   "desc"
    t.integer  "value"
    t.string   "box_movement_type"
    t.integer  "user_id"
    t.integer  "currency_id"
    t.integer  "work_order_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.integer  "work_order_id"
    t.integer  "total"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "subtotal_rep"
    t.integer  "subtotal_work_does"
    t.integer  "subtotal_rep_dol"
    t.integer  "total_dol"
    t.integer  "subtotal_work_does_dol"
    t.integer  "discount"
    t.integer  "total_budget_pay"
    t.integer  "total_budget_pay_dol"
    t.integer  "subtotal"
    t.integer  "subtotal_dol"
    t.integer  "iva"
    t.integer  "iva_dol"
  end

  add_index "budgets", ["work_order_id"], name: "index_budgets_on_work_order_id", using: :btree

  create_table "car_brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
  end

  create_table "customers", force: :cascade do |t|
    t.string "owner"
    t.string "invoice_name"
    t.string "rut"
    t.string "phone"
    t.string "address"
    t.string "email"
  end

  create_table "ivas", force: :cascade do |t|
    t.integer "value"
  end

  create_table "replacements", force: :cascade do |t|
    t.string  "name"
    t.string  "price"
    t.integer "work_order_id"
    t.string  "currency"
  end

  add_index "replacements", ["work_order_id"], name: "index_replacements_on_work_order_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "user_type"
    t.string "password",           limit: 128, default: "", null: false
    t.string "username"
    t.string "encrypted_password"
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "model"
    t.string   "displacement"
    t.string   "year"
    t.string   "plate"
    t.string   "color"
    t.string   "chassis_number"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "active",         default: true
    t.integer  "car_brand_id"
  end

  create_table "work_dones", force: :cascade do |t|
    t.integer  "work_order_id"
    t.string   "work"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "price"
    t.string   "currency"
  end

  add_index "work_dones", ["work_order_id"], name: "index_work_dones_on_work_order_id", using: :btree

  create_table "work_ins", force: :cascade do |t|
    t.integer "work_order_id"
    t.string  "work"
    t.boolean "done"
  end

  add_index "work_ins", ["work_order_id"], name: "index_work_ins_on_work_order_id", using: :btree

  create_table "work_orders", force: :cascade do |t|
    t.integer  "number"
    t.integer  "customer_id"
    t.integer  "vehicle_id"
    t.string   "km"
    t.string   "fuel"
    t.text     "coments"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "status"
    t.integer  "received_by_id"
    t.integer  "delivered_by_id"
    t.integer  "worked_by_id"
    t.text     "observation"
    t.datetime "deliver_date"
    t.datetime "date_in"
  end

  add_index "work_orders", ["customer_id"], name: "index_work_orders_on_customer_id", using: :btree
  add_index "work_orders", ["vehicle_id"], name: "index_work_orders_on_vehicle_id", using: :btree

  add_foreign_key "budgets", "work_orders"
  add_foreign_key "replacements", "work_orders"
  add_foreign_key "work_dones", "work_orders"
  add_foreign_key "work_ins", "work_orders"
  add_foreign_key "work_orders", "customers"
  add_foreign_key "work_orders", "vehicles"
end
