# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_01_06_092052) do
  create_table "invoices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "cgst_total", precision: 15, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.text "customer_address"
    t.string "customer_email"
    t.string "customer_gstin"
    t.string "customer_name"
    t.string "customer_phone"
    t.string "financed_by"
    t.decimal "grand_total", precision: 15, scale: 2, default: "0.0"
    t.date "invoice_date"
    t.string "invoice_number"
    t.decimal "sgst_total", precision: 15, scale: 2, default: "0.0"
    t.decimal "sub_total", precision: 15, scale: 2, default: "0.0"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "line_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "cgst_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "cgst_rate", precision: 5, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "hsn_code"
    t.bigint "invoice_id", null: false
    t.integer "quantity"
    t.decimal "rate", precision: 15, scale: 2, default: "0.0"
    t.string "serial_number"
    t.decimal "sgst_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "sgst_rate", precision: 5, scale: 2, default: "0.0"
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_line_items_on_invoice_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "invoices", "users"
  add_foreign_key "line_items", "invoices"
end
