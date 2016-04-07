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

ActiveRecord::Schema.define(version: 20160406230833) do

  create_table "collections", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enclosures", force: :cascade do |t|
    t.string   "filename"
    t.integer  "ied_record_id"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eppi_breviates", force: :cascade do |t|
    t.string   "title"
    t.integer  "volume_id"
    t.string   "name"
    t.string   "year"
    t.string   "keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eppi_doctypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eppi_documents", force: :cascade do |t|
    t.string   "paper_no"
    t.string   "authoritative_ref"
    t.string   "title_actual"
    t.string   "corp_authors"
    t.string   "personal_author"
    t.string   "publisher"
    t.string   "breviate_page"
    t.string   "tables"
    t.string   "series"
    t.string   "chairman"
    t.string   "abstract"
    t.string   "pages_sectioned"
    t.string   "held_by"
    t.string   "additional_components"
    t.string   "start_page"
    t.string   "vol"
    t.string   "subvol_arabic"
    t.integer  "eppi_lc_subject_id"
    t.string   "published"
    t.string   "appointed"
    t.string   "source"
    t.integer  "eppi_session_id"
    t.integer  "eppi_doctype_id"
    t.integer  "eppi_breviate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session"
  end

  add_index "eppi_documents", ["authoritative_ref"], name: "index_eppi_documents_on_authoritative_ref"
  add_index "eppi_documents", ["eppi_breviate_id"], name: "index_eppi_documents_on_eppi_breviate_id"
  add_index "eppi_documents", ["eppi_doctype_id"], name: "index_eppi_documents_on_eppi_doctype_id"
  add_index "eppi_documents", ["eppi_lc_subject_id"], name: "index_eppi_documents_on_eppi_lc_subject_id"
  add_index "eppi_documents", ["eppi_session_id"], name: "index_eppi_documents_on_eppi_session_id"
  add_index "eppi_documents", ["paper_no"], name: "index_eppi_documents_on_paper_no"

  create_table "eppi_keywords", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eppi_lc_subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "parent_id"
    t.string   "full_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eppi_pages", force: :cascade do |t|
    t.integer  "eppi_document_id"
    t.integer  "ordinal"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eppi_pages", ["eppi_document_id"], name: "index_eppi_pages_on_eppi_document_id"

  create_table "eppi_sessions", force: :cascade do |t|
    t.string "from"
    t.string "to"
  end

  create_table "eppi_volumes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ied_cat_files", force: :cascade do |t|
    t.string   "filename"
    t.string   "filesize"
    t.string   "ied_cat_files", limit: 4
    t.string   "description"
    t.string   "string"
    t.integer  "category_id"
    t.integer  "integer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ied_catalogues", force: :cascade do |t|
    t.string   "title"
    t.string   "source"
    t.string   "archive"
    t.string   "serial"
    t.string   "catdate"
    t.string   "tags"
    t.string   "transcript"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ied_categories", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "reference"
    t.string   "description"
    t.boolean  "show",        default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ied_enclosures", force: :cascade do |t|
    t.string   "ied_record_id"
    t.string   "filename"
    t.string   "label"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ied_institutions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ied_pages", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "ordinal"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ied_records", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "someid"
    t.string   "name"
    t.string   "srcdoc"
    t.string   "source"
    t.string   "somenum"
    t.string   "somenum2"
    t.string   "added"
    t.string   "chapcode"
    t.text     "transcript"
    t.integer  "institution_id"
    t.integer  "ied_chapter_id"
    t.string   "ied_chapcode"
    t.date     "timestamp"
    t.string   "archive"
    t.string   "serial"
    t.string   "recorddate"
    t.string   "recordlog"
    t.string   "recordtype"
    t.string   "catid"
    t.string   "partialdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interviews", force: :cascade do |t|
    t.string   "name"
    t.text     "summary"
    t.integer  "denomination_id"
    t.integer  "gender_id"
    t.integer  "place_of_birth"
    t.integer  "residence"
    t.integer  "childhood_residence"
    t.string   "duration"
    t.datetime "timestamp"
    t.integer  "age_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "document_id",      limit: 3,        null: false
    t.integer "ordinal",          limit: 2
    t.text    "content",          limit: 16777215
    t.integer "chapter_id",       limit: 3
    t.string  "record_id",        limit: 100
    t.text    "clean_content",    limit: 16777215
    t.integer "eppi_document_id"
  end

  add_index "pages", ["document_id"], name: "document_id"

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string   "subdomain"
    t.string   "title"
    t.string   "short_title"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "summary_documents", force: :cascade do |t|
    t.string   "title"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "boost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vmr_age_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vmr_decades", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vmr_denominations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vmr_destinations", force: :cascade do |t|
    t.integer  "place_id"
    t.integer  "position"
    t.integer  "vmr_interview_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vmr_emigrations", force: :cascade do |t|
    t.integer  "vmr_interview_id"
    t.integer  "vmr_decade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vmr_genders", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vmr_interviews", force: :cascade do |t|
    t.string   "code"
    t.text     "summary"
    t.integer  "vmr_denomination_id"
    t.integer  "vmr_gender_id"
    t.integer  "birthplace_id"
    t.integer  "residence_id"
    t.integer  "childhood_residence_id"
    t.string   "duration"
    t.date     "date"
    t.integer  "vmr_age_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vmr_keywords", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vmr_returns", force: :cascade do |t|
    t.integer  "vmr_interview_id"
    t.integer  "vmr_decade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vmr_tracks", force: :cascade do |t|
    t.integer  "track_id"
    t.integer  "track_no"
    t.string   "duration"
    t.string   "keywords"
    t.integer  "vmr_interview_id"
    t.string   "keywordstr"
    t.string   "durationstr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
