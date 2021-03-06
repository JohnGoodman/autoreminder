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

ActiveRecord::Schema.define(:version => 20111005011211) do

  create_table "ckeditor_assets", :force => true do |t|
    t.string    "data_file_name",                  :null => false
    t.string    "data_content_type"
    t.integer   "data_file_size"
    t.integer   "assetable_id"
    t.string    "assetable_type",    :limit => 30
    t.string    "type",              :limit => 30
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "companies", :force => true do |t|
    t.string    "name"
    t.string    "address"
    t.string    "address_two"
    t.string    "phone"
    t.string    "phone_two"
    t.string    "email"
    t.string    "fax"
    t.string    "city"
    t.string    "state"
    t.integer   "zip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "office"
    t.string    "sub_item_title"
    t.string    "store_title"
    t.integer   "reminder_type_id"
    t.string    "avatar"
    t.integer   "company_type_id"
    t.text      "thank_you_text"
    t.string    "thank_you_subject"
    t.boolean   "additional_vehicle_fields"
  end

  create_table "customer_service_reminders", :force => true do |t|
    t.integer   "vehicle_id"
    t.integer   "service_reminder_id"
    t.date      "sent_on"
    t.integer   "interval"
    t.boolean   "recurring"
    t.integer   "times_sent",              :default => 0
    t.integer   "max_send",                :default => 1
    t.string    "custom_name"
    t.text      "custom_description"
    t.string    "custom_email_subject"
    t.text      "custom_email_body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "person_id"
    t.timestamp "appointment_date"
    t.string    "appointment_description"
    t.integer   "pet_id"
  end

  create_table "emails", :force => true do |t|
    t.integer  "person_id"
    t.string   "subject"
    t.string   "preview_to"
    t.text     "body"
    t.boolean  "template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
    t.integer  "company_id"
    t.boolean  "advertisement"
    t.string   "advertisement_image"
    t.string   "advertisement_subject"
  end

  create_table "people", :force => true do |t|
    t.string    "email"
    t.string    "encrypted_password",     :limit => 128
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                         :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.integer   "role_id"
    t.integer   "store_id"
    t.string    "first_name"
    t.string    "last_name"
    t.string    "prefix"
    t.boolean   "online_access",                         :default => false
    t.text      "note"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "username"
    t.integer   "company_id"
    t.boolean   "unsubscribe"
    t.boolean   "send_mass_emails"
  end

  add_index "people", ["reset_password_token"], :name => "index_people_on_reset_password_token", :unique => true

  create_table "people_stores", :id => false, :force => true do |t|
    t.integer "person_id"
    t.integer "store_id"
  end

  create_table "pets", :force => true do |t|
    t.integer   "person_id"
    t.string    "name"
    t.boolean   "unsubscribe"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "service_reminders", :force => true do |t|
    t.integer   "store_id"
    t.string    "name"
    t.text      "description"
    t.string    "email_subject"
    t.text      "email_body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "company_id"
  end

  create_table "stores", :force => true do |t|
    t.integer   "company_id"
    t.string    "name"
    t.string    "address"
    t.string    "address_two"
    t.string    "phone"
    t.string    "phone_two"
    t.string    "email"
    t.string    "fax"
    t.string    "city"
    t.string    "state"
    t.integer   "zip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "vehicles", :force => true do |t|
    t.integer   "person_id"
    t.integer   "year"
    t.string    "make"
    t.string    "model"
    t.string    "email"
    t.boolean   "unsubscribe"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "average_miles_per_year"
    t.integer   "milage_at_signup"
    t.integer   "current_milage"
  end

end
