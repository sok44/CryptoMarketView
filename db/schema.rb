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

ActiveRecord::Schema.define(version: 20180714184726) do

  create_table "currencies", force: :cascade do |t|
    t.string "short_name"
    t.string "full_name"
    t.boolean "crypto"
    t.string "description"
    t.integer "tick_precision", limit: 8
    t.integer "volume_precision", limit: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currency_pairs", force: :cascade do |t|
    t.string "name"
    t.integer "base_currency_id"
    t.integer "quote_currency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_currency_id"], name: "index_currency_pairs_on_base_currency_id"
    t.index ["quote_currency_id"], name: "index_currency_pairs_on_quote_currency_id"
  end

  create_table "market_currency_pair_names", force: :cascade do |t|
    t.integer "market_id"
    t.integer "currency_pair_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_pair_id"], name: "index_market_currency_pair_names_on_currency_pair_id"
    t.index ["market_id"], name: "index_market_currency_pair_names_on_market_id"
  end

  create_table "market_period_names", force: :cascade do |t|
    t.integer "market_id"
    t.integer "period_quotation_type_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_id"], name: "index_market_period_names_on_market_id"
    t.index ["period_quotation_type_id"], name: "index_market_period_names_on_period_quotation_type_id"
  end

  create_table "market_symbol_precisions", force: :cascade do |t|
    t.integer "currency_pair_id"
    t.integer "market_id"
    t.integer "tick_precision", limit: 8
    t.integer "volume_precision", limit: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_pair_id"], name: "index_market_symbol_precisions_on_currency_pair_id"
    t.index ["market_id"], name: "index_market_symbol_precisions_on_market_id"
  end

  create_table "markets", force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "adapter_name"
  end

  create_table "period_quotation_types", force: :cascade do |t|
    t.string "short_name"
    t.string "long_name"
    t.integer "time_interval_id"
    t.integer "count_intervals"
    t.index ["time_interval_id"], name: "index_period_quotation_types_on_time_interval_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.integer "currency_pair_id"
    t.integer "market_id"
    t.integer "period_quotation_type_id"
    t.datetime "datetime_tick"
    t.integer "open_tick", limit: 8
    t.integer "high_tick", limit: 8
    t.integer "low_tick", limit: 8
    t.integer "close_tick", limit: 8
    t.integer "volume_tick", limit: 8
    t.index ["currency_pair_id"], name: "index_quotations_on_currency_pair_id"
    t.index ["market_id", "currency_pair_id", "period_quotation_type_id", "datetime_tick"], name: "unique_by_market_symbol_period_date", unique: true
    t.index ["market_id"], name: "index_quotations_on_market_id"
    t.index ["period_quotation_type_id"], name: "index_quotations_on_period_quotation_type_id"
  end

  create_table "time_intervals", force: :cascade do |t|
    t.string "name"
  end

end
