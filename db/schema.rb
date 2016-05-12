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

ActiveRecord::Schema.define(version: 20160512141544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "destinations", force: :cascade do |t|
    t.string   "planet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_packages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_packages", ["order_id"], name: "index_order_packages_on_order_id", using: :btree
  add_index "order_packages", ["package_id"], name: "index_order_packages_on_package_id", using: :btree
  add_index "order_packages", ["user_id"], name: "index_order_packages_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "status",                              default: 0
    t.decimal  "total_cost", precision: 20, scale: 2
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "photo_categories", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "photo_categories", ["category_id"], name: "index_photo_categories_on_category_id", using: :btree
  add_index "photo_categories", ["photo_id"], name: "index_photo_categories_on_photo_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "vendor_id"
    t.integer  "price"
  end

  add_index "photos", ["vendor_id"], name: "index_photos_on_vendor_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "vendor_id"
    t.integer "role_id"
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree
  add_index "user_roles", ["vendor_id"], name: "index_user_roles_on_vendor_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.string   "password_confirmation"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.string   "about"
  end

  add_foreign_key "order_packages", "orders"
  add_foreign_key "order_packages", "photos", column: "package_id"
  add_foreign_key "order_packages", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "photo_categories", "categories"
  add_foreign_key "photo_categories", "photos"
  add_foreign_key "photos", "vendors"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "user_roles", "vendors"
end
