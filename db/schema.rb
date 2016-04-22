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

ActiveRecord::Schema.define(version: 20160417084144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "industry_id"
    t.string   "symbol"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "skip_historical_data", default: false
  end

  add_index "companies", ["industry_id"], name: "index_companies_on_industry_id", using: :btree
  add_index "companies", ["name", "symbol", "industry_id"], name: "index_companies_on_name_and_symbol_and_industry_id", unique: true, using: :btree
  add_index "companies", ["name"], name: "index_companies_on_name", unique: true, using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historical_data", force: :cascade do |t|
    t.date     "trade_date"
    t.decimal  "open"
    t.decimal  "high"
    t.decimal  "low"
    t.decimal  "close"
    t.integer  "volume"
    t.decimal  "adjusted_close"
    t.integer  "company_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "historical_data", ["company_id"], name: "index_historical_data_on_company_id", using: :btree

  create_table "industries", force: :cascade do |t|
    t.string   "name"
    t.integer  "sector_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "industries", ["name", "sector_id"], name: "index_industries_on_name_and_sector_id", unique: true, using: :btree
  add_index "industries", ["sector_id"], name: "index_industries_on_sector_id", using: :btree

  create_table "markets", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "markets", ["country_id"], name: "index_markets_on_country_id", using: :btree
  add_index "markets", ["name", "country_id"], name: "index_markets_on_name_and_country_id", unique: true, using: :btree

  create_table "sectors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sectors", ["name"], name: "index_sectors_on_name", unique: true, using: :btree

  add_foreign_key "companies", "industries"
  add_foreign_key "historical_data", "companies"
  add_foreign_key "industries", "sectors"
  add_foreign_key "markets", "countries"
end
