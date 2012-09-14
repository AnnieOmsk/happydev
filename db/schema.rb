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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120914120323) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "companies", ["city_id"], :name => "index_companies_on_city_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "master"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "place"
    t.integer  "priority"
    t.boolean  "discount"
  end

  create_table "events_payments", :id => false, :force => true do |t|
    t.integer "payment_id"
    t.integer "event_id"
  end

  add_index "events_payments", ["event_id"], :name => "index_events_payments_on_event_id"
  add_index "events_payments", ["payment_id"], :name => "index_events_payments_on_payment_id"

  create_table "invoice_events", :force => true do |t|
    t.integer  "invoice_id"
    t.integer  "event_id"
    t.boolean  "paid",        :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "paid_amount"
  end

  add_index "invoice_events", ["event_id"], :name => "index_invoice_events_on_event_id"
  add_index "invoice_events", ["invoice_id"], :name => "index_invoice_events_on_invoice_id"

  create_table "invoices", :force => true do |t|
    t.integer  "user_id"
    t.integer  "amount"
    t.datetime "expired_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "code"
    t.boolean  "discount_status", :default => false
    t.string   "promocode"
    t.boolean  "oferta",          :default => false
    t.integer  "reserve_user_id"
    t.boolean  "robox_flag",      :default => false
    t.boolean  "clearing",        :default => false
  end

  add_index "invoices", ["user_id"], :name => "index_invoices_on_user_id"

  create_table "payments", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "invoice_id"
    t.integer  "amount"
  end

  create_table "promocodes", :force => true do |t|
    t.integer  "discount_value"
    t.string   "number"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "name"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "rich_rich_files", :force => true do |t|
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        :default => "file"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.string   "hall"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "speakers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "personal_url"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "vk"
    t.string   "github"
    t.string   "moikrug"
    t.string   "slideshare"
    t.text     "description"
    t.integer  "city_id"
    t.integer  "company_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "position"
    t.string   "photo_url"
  end

  add_index "speakers", ["city_id"], :name => "index_speakers_on_city_id"
  add_index "speakers", ["company_id"], :name => "index_speakers_on_company_id"

  create_table "specializations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "speeches", :force => true do |t|
    t.string   "title"
    t.text     "annotation"
    t.text     "description"
    t.integer  "speaker_id"
    t.integer  "section_id"
    t.integer  "specialization_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.datetime "start_time"
    t.integer  "timing"
    t.string   "permalink"
  end

  add_index "speeches", ["permalink"], :name => "index_speeches_on_permalink"
  add_index "speeches", ["section_id"], :name => "index_speeches_on_section_id"
  add_index "speeches", ["speaker_id"], :name => "index_speeches_on_speaker_id"
  add_index "speeches", ["specialization_id"], :name => "index_speeches_on_specialization_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "company"
    t.string   "city"
    t.string   "professional"
    t.boolean  "student"
    t.string   "promocode"
    t.string   "first_name",             :default => "",    :null => false
    t.string   "last_name",              :default => "",    :null => false
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
