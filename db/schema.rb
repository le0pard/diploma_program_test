# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100328200715) do

  create_table "web_results", :force => true do |t|
    t.integer  "web_task_id"
    t.integer  "count",            :default => 0
    t.string   "cpu_avr1"
    t.string   "cpu_avr5"
    t.string   "cpu_avr15"
    t.string   "mem_total"
    t.string   "mem_used"
    t.string   "mem_free"
    t.string   "swap_total"
    t.string   "swap_used"
    t.string   "swap_free"
    t.integer  "process_all"
    t.integer  "process_running"
    t.decimal  "server_load_time"
    t.decimal  "web_load_time"
    t.text     "html_data"
    t.datetime "time_of_test"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "web_tasks", :force => true do |t|
    t.integer  "web_test_id"
    t.string   "url"
    t.integer  "http_method",  :default => 0
    t.text     "http_params",  :default => ""
    t.integer  "count_repeat", :default => 0
    t.integer  "sort",         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "web_tests", :force => true do |t|
    t.string   "name"
    t.boolean  "launched",    :default => false
    t.datetime "resulted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
