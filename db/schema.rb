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

ActiveRecord::Schema.define(version: 2020_11_18_024756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "text", null: false
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "leads", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.string "client_name", null: false
    t.string "client_email", null: false
    t.string "client_contact", null: false
    t.string "client_address", null: false
    t.datetime "transition_date"
    t.string "leadType", null: false
    t.integer "is_sale", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leads_on_user_id"
  end

  create_table "phase_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "phase_id", null: false
    t.text "description", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phase_id"], name: "index_phase_users_on_phase_id"
    t.index ["user_id"], name: "index_phase_users_on_user_id"
  end

  create_table "phases", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "lead_id", null: false
    t.bigint "user_id"
    t.text "description", null: false
    t.string "phaseType", null: false
    t.integer "status", default: 0
    t.datetime "start_date", null: false
    t.datetime "due_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lead_id"], name: "index_phases_on_lead_id"
    t.index ["user_id"], name: "index_phases_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "lead_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lead_id"], name: "index_projects_on_lead_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "phase_id", null: false
    t.bigint "user_id", null: false
    t.string "status", default: "Pending", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phase_id"], name: "index_requests_on_phase_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "contact_no", default: "", null: false
    t.string "address", default: "", null: false
    t.string "about", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "leads", "users"
  add_foreign_key "phase_users", "phases"
  add_foreign_key "phase_users", "users"
  add_foreign_key "phases", "leads"
  add_foreign_key "phases", "users"
  add_foreign_key "projects", "leads"
  add_foreign_key "projects", "users"
  add_foreign_key "requests", "phases"
  add_foreign_key "requests", "users"
end
