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

ActiveRecord::Schema.define(version: 20160322110617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stats", force: :cascade do |t|
    t.float    "percents"
    t.integer  "threads_count"
    t.datetime "start"
    t.datetime "finish"
    t.integer  "time_delta"
  end

  add_index "stats", ["finish"], name: "index_stats_on_finish", using: :btree
  add_index "stats", ["percents"], name: "index_stats_on_percents", using: :btree
  add_index "stats", ["start"], name: "index_stats_on_start", using: :btree
  add_index "stats", ["threads_count"], name: "index_stats_on_threads_count", using: :btree
  add_index "stats", ["time_delta"], name: "index_stats_on_time_delta", using: :btree

  create_table "threads_pad_job_logs", force: :cascade do |t|
    t.integer  "job_reflection_id"
    t.integer  "level"
    t.integer  "group_id"
    t.text     "msg"
    t.datetime "created_at",        null: false
  end

  add_index "threads_pad_job_logs", ["job_reflection_id"], name: "index_threads_pad_job_logs_on_job_reflection_id", using: :btree

  create_table "threads_pad_jobs", force: :cascade do |t|
    t.boolean "terminated"
    t.string  "thread_id"
    t.boolean "done"
    t.string  "result"
    t.integer "group_id"
    t.integer "integer"
    t.integer "max"
    t.integer "current"
    t.integer "min"
    t.boolean "started"
    t.boolean "destroy_on_finish"
  end

  add_index "threads_pad_jobs", ["group_id"], name: "index_threads_pad_jobs_on_group_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.string   "units"
    t.string   "serial"
    t.string   "model_type"
    t.integer  "ship_id"
    t.datetime "ship_date"
    t.string   "customer_no"
    t.string   "order_no"
  end

  add_index "units", ["customer_no"], name: "index_units_on_customer_no", using: :btree
  add_index "units", ["model_type"], name: "index_units_on_model_type", using: :btree
  add_index "units", ["order_no"], name: "index_units_on_order_no", using: :btree
  add_index "units", ["serial"], name: "index_units_on_serial", using: :btree
  add_index "units", ["ship_date"], name: "index_units_on_ship_date", using: :btree
  add_index "units", ["ship_id"], name: "index_units_on_ship_id", using: :btree

end
