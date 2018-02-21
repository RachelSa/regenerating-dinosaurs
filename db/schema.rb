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

ActiveRecord::Schema.define(version: 20180221203557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carousels", id: :serial, force: :cascade do |t|
    t.string "photo_1_file_name"
    t.string "photo_1_content_type"
    t.integer "photo_1_file_size"
    t.datetime "photo_1_updated_at"
    t.string "photo_2_file_name"
    t.string "photo_2_content_type"
    t.integer "photo_2_file_size"
    t.datetime "photo_2_updated_at"
    t.string "photo_3_file_name"
    t.string "photo_3_content_type"
    t.integer "photo_3_file_size"
    t.datetime "photo_3_updated_at"
    t.string "photo_4_file_name"
    t.string "photo_4_content_type"
    t.integer "photo_4_file_size"
    t.datetime "photo_4_updated_at"
  end

  create_table "classrooms", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "street_address"
    t.string "town"
    t.string "zipcode"
    t.string "image_url"
    t.text "description"
    t.string "phone"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "collaborations", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "phone"
    t.string "ext"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dinosaurs", force: :cascade do |t|
    t.string "species"
    t.integer "health"
    t.integer "happiness"
    t.integer "radiating_positivity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parent_resources", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.text "content"
    t.string "upload_attachment_file_name"
    t.string "upload_attachment_content_type"
    t.integer "upload_attachment_file_size"
    t.datetime "upload_attachment_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "program_classrooms", id: :serial, force: :cascade do |t|
    t.integer "program_id"
    t.integer "classroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "programs", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "early_care_education", default: false
    t.boolean "supporting_families_communities", default: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "super", default: false
  end

end
