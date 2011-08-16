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

ActiveRecord::Schema.define(:version => 20110815015745) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "address_two"
    t.string   "phone"
    t.string   "phone_two"
    t.string   "email"
    t.string   "fax"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "office"
    t.string   "sub_item_title"
    t.string   "store_title"
    t.integer  "reminder_type_id"
  end

  create_table "customer_service_reminders", :force => true do |t|
    t.integer  "vehicle_id"
    t.integer  "service_reminder_id"
    t.date     "sent_on"
    t.integer  "interval"
    t.boolean  "recurring"
    t.integer  "times_sent"
    t.integer  "max_send"
    t.string   "custom_name"
    t.text     "custom_description"
    t.string   "custom_email_subject"
    t.text     "custom_email_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.datetime "appointment_date"
    t.string   "appointment_description"
  end

  create_table "people", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",     :limit => 128
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role_id"
    t.integer  "store_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "prefix"
    t.boolean  "online_access",                         :default => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["reset_password_token"], :name => "index_people_on_reset_password_token", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_reminders", :force => true do |t|
    t.integer  "store_id"
    t.string   "name"
    t.text     "description"
    t.string   "email_subject"
    t.text     "email_body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "address"
    t.string   "address_two"
    t.string   "phone"
    t.string   "phone_two"
    t.string   "email"
    t.string   "fax"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", :force => true do |t|
    t.integer  "person_id"
    t.integer  "year"
    t.string   "make"
    t.string   "model"
    t.string   "email"
    t.boolean  "unsubscribe"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
