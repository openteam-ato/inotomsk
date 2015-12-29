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

ActiveRecord::Schema.define(version: 20151229053628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.float   "latitude"
    t.float   "longitude"
    t.integer "placemark_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.date     "date_on"
    t.text     "tags"
    t.string   "kind"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "file_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_fingerprint"
    t.string   "number"
  end

  create_table "events", force: :cascade do |t|
    t.text     "title"
    t.text     "document_type"
    t.text     "performer"
    t.string   "term_type",     limit: 255
    t.integer  "start_year"
    t.integer  "end_year"
    t.string   "quarter",       limit: 255
    t.string   "state",         limit: 255
    t.integer  "map_layer_id"
    t.integer  "placemark_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "language",      limit: 255
  end

  create_table "map_layers", force: :cascade do |t|
    t.string   "title",                   limit: 255
    t.string   "slug",                    limit: 255
    t.string   "icon_file_name",          limit: 255
    t.string   "icon_content_type",       limit: 255
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.text     "icon_url"
    t.string   "hover_icon_file_name",    limit: 255
    t.string   "hover_icon_content_type", limit: 255
    t.integer  "hover_icon_file_size"
    t.datetime "hover_icon_updated_at"
    t.text     "hover_icon_url"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "ancestry",                limit: 255
    t.integer  "position"
    t.boolean  "visible"
  end

  add_index "map_layers", ["ancestry"], name: "index_map_layers_on_ancestry", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "context_type", limit: 255
    t.string   "role",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "permissions", ["user_id", "role"], name: "by_user_and_role", using: :btree

  create_table "placemarks", force: :cascade do |t|
    t.text     "title"
    t.text     "slug"
    t.string   "logotype_file_name",    limit: 255
    t.string   "logotype_content_type", limit: 255
    t.integer  "logotype_file_size"
    t.datetime "logotype_updated_at"
    t.text     "logotype_url"
    t.integer  "map_layer_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "description"
  end

  create_table "related_documents", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "related_document_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "uid",                    limit: 255
    t.text     "name"
    t.string   "email"
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
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",                  default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
