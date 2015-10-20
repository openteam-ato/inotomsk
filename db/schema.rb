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

ActiveRecord::Schema.define(:version => 20151020052713) do

  create_table "addresses", :force => true do |t|
    t.float   "latitude"
    t.float   "longitude"
    t.integer "placemark_id"
  end

  create_table "events", :force => true do |t|
    t.text     "title"
    t.text     "document_type"
    t.text     "performer"
    t.string   "term_type"
    t.integer  "start_year"
    t.integer  "end_year"
    t.string   "quarter"
    t.string   "state"
    t.integer  "map_layer_id"
    t.integer  "placemark_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "language"
  end

  create_table "map_layers", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.text     "icon_url"
    t.string   "hover_icon_file_name"
    t.string   "hover_icon_content_type"
    t.integer  "hover_icon_file_size"
    t.datetime "hover_icon_updated_at"
    t.text     "hover_icon_url"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "ancestry"
    t.integer  "position"
    t.boolean  "visible"
  end

  add_index "map_layers", ["ancestry"], :name => "index_map_layers_on_ancestry"

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.string   "role"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "permissions", ["user_id", "role"], :name => "by_user_and_role"

  create_table "placemarks", :force => true do |t|
    t.text     "title"
    t.text     "slug"
    t.string   "logotype_file_name"
    t.string   "logotype_content_type"
    t.integer  "logotype_file_size"
    t.datetime "logotype_updated_at"
    t.text     "logotype_url"
    t.integer  "map_layer_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.text     "description"
  end

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.text     "name"
    t.text     "email"
    t.text     "nickname"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "location"
    t.text     "description"
    t.text     "image"
    t.text     "phone"
    t.text     "urls"
    t.text     "raw_info"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "users", ["uid"], :name => "index_users_on_uid"

end
