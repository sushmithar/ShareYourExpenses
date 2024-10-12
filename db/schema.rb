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

ActiveRecord::Schema[7.1].define(version: 2024_10_12_070941) do
  create_table "expense_transactions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.bigint "payer_id", null: false
    t.bigint "payee_id", null: false
    t.decimal "amount_paid", precision: 10, scale: 2, null: false
    t.datetime "transaction_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_expense_transactions_on_expense_id"
    t.index ["payee_id"], name: "index_expense_transactions_on_payee_id"
    t.index ["payer_id"], name: "index_expense_transactions_on_payer_id"
  end

  create_table "expenses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.string "name"
    t.decimal "total_amount", precision: 10
    t.string "category"
    t.boolean "split_equaly"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_expenses_on_group_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "group_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "group_name"
    t.text "description"
    t.string "group_type"
    t.string "currency"
    t.boolean "IsSimplifyDebtEnabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "expense_transactions", "expenses"
  add_foreign_key "expense_transactions", "users", column: "payee_id"
  add_foreign_key "expense_transactions", "users", column: "payer_id"
  add_foreign_key "expenses", "groups"
  add_foreign_key "expenses", "users"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
end
