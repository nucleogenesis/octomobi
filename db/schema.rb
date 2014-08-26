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

ActiveRecord::Schema.define(version: 20140826013940) do

  create_table "admins", force: true do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "contact_features", force: true do |t|
    t.string   "email_contact"
    t.string   "phone_contact"
    t.string   "fax_contact"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "order"
  end

  create_table "content_page_features", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "order"
  end

  create_table "customers", force: true do |t|
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["confirmation_token"], name: "index_customers_on_confirmation_token", unique: true
  add_index "customers", ["email"], name: "index_customers_on_email", unique: true
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true

  create_table "external_links_features", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "order"
  end

  create_table "gallery_images", force: true do |t|
    t.integer  "image_gallery_feature_id"
    t.string   "image_location"
    t.string   "alt"
    t.string   "link_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  create_table "guests", force: true do |t|
    t.string   "email",              default: "",     null: false
    t.string   "encrypted_password", default: "",     null: false
    t.string   "preview_url",        default: "null"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guests", ["email"], name: "index_guests_on_email", unique: true

  create_table "image_gallery_features", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "order"
  end

  create_table "introduction_features", force: true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.string   "title"
    t.integer  "order"
  end

  create_table "payments", force: true do |t|
    t.integer  "customer_id"
    t.integer  "subscription_id"
    t.integer  "amount"
    t.boolean  "successful"
    t.string   "coupon_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rss_feed_features", force: true do |t|
    t.string   "title"
    t.string   "feed_url"
    t.integer  "entries_to_show"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "order"
  end

  create_table "sites", force: true do |t|
    t.integer  "customer_id"
    t.string   "basic_redirect"
    t.string   "pro_redirect"
    t.string   "google_analytics_api_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "desktop_site_url"
    t.string   "logo_location"
    t.boolean  "is_active"
    t.string   "preview_url"
  end

  create_table "social_links_features", force: true do |t|
    t.string   "twitter_url"
    t.string   "facebook_url"
    t.string   "google_plus_url"
    t.string   "pinterest_url"
    t.string   "instagram_url"
    t.string   "linkedin_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "customer_id"
    t.datetime "payment_due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",         default: false
    t.boolean  "auto_payment",      default: false
    t.string   "subscription_type", default: "basic"
    t.datetime "expiry_date"
  end

end
