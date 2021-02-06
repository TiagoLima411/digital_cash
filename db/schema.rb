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

ActiveRecord::Schema.define(version: 2020_06_13_224923) do

  create_table "account_balances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "available_value_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_account_balances_on_user_id"
  end

  create_table "account_extracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_balance_id"
    t.integer "reference_id"
    t.integer "value_cents"
    t.integer "balance_cents"
    t.string "description"
    t.integer "type_register"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_balance_id"], name: "index_account_extracts_on_account_balance_id"
    t.index ["user_id"], name: "index_account_extracts_on_user_id"
  end

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "bank_id"
    t.boolean "active", default: true
    t.string "agency_number"
    t.string "account_number"
    t.integer "account_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_accounts_on_bank_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "bank_transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "benefited_user_id"
    t.integer "spread_fee_cents"
    t.integer "net_value_cents"
    t.integer "gross_value_cents"
    t.string "description"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bank_transactions_on_user_id"
  end

  create_table "banks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "state_id"
    t.boolean "capitol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "incomes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "intype"
    t.integer "reference_id"
    t.integer "value_cents"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "logged_exceptions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "exception_class"
    t.string "controller_name"
    t.string "action_name"
    t.text "message"
    t.text "backtrace"
    t.text "environment"
    t.text "request"
    t.datetime "created_at"
  end

  create_table "members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.date "birthday"
    t.integer "gender"
    t.string "mother_name"
    t.string "cpf"
    t.string "rg"
    t.string "phone"
    t.string "address"
    t.string "zipcode"
    t.bigint "city_id"
    t.bigint "state_id"
    t.string "complement"
    t.string "number"
    t.string "district"
    t.string "address_number"
    t.string "address_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_members_on_city_id"
    t.index ["state_id"], name: "index_members_on_state_id"
  end

  create_table "nobe_revenues", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "bank_transaction_id"
    t.string "description"
    t.integer "value_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_transaction_id"], name: "index_nobe_revenues_on_bank_transaction_id"
    t.index ["user_id"], name: "index_nobe_revenues_on_user_id"
  end

  create_table "outgoings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "outtype"
    t.integer "reference_id"
    t.integer "value_cents"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_outgoings_on_user_id"
  end

  create_table "rate_settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "day_of_week"
    t.integer "rate_cents"
    t.integer "alternative_rate_cents"
    t.time "initial_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "uf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "payment_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "role", default: 1, null: false
    t.boolean "active", default: true
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_users_on_member_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "account_balances", "users"
  add_foreign_key "account_extracts", "account_balances"
  add_foreign_key "account_extracts", "users"
  add_foreign_key "accounts", "banks"
  add_foreign_key "accounts", "users"
  add_foreign_key "bank_transactions", "users"
  add_foreign_key "cities", "states"
  add_foreign_key "incomes", "users"
  add_foreign_key "members", "cities"
  add_foreign_key "members", "states"
  add_foreign_key "nobe_revenues", "bank_transactions"
  add_foreign_key "nobe_revenues", "users"
  add_foreign_key "outgoings", "users"
  add_foreign_key "users", "members"
end
