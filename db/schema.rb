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

ActiveRecord::Schema.define(version: 20190612193016) do

  create_table "assignments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_assignments_on_role_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "course_number"
    t.string "instructor"
    t.string "instructor_username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "semester_id"
    t.integer "department_id"
    t.integer "library_id"
    t.string "instructor_email"
    t.index ["department_id"], name: "index_courses_on_department_id"
    t.index ["library_id"], name: "index_courses_on_library_id"
    t.index ["semester_id"], name: "index_courses_on_semester_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "publication_date"
    t.string "publisher"
    t.string "edition"
    t.string "owner"
    t.string "call_number"
    t.string "note"
    t.integer "iucat_id"
    t.string "bod_format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.integer "item_status_id"
    t.boolean "will_supply"
    t.boolean "purchase"
    t.integer "loan_period_id"
    t.integer "user_id"
    t.index ["course_id"], name: "index_items_on_course_id"
    t.index ["item_status_id"], name: "index_items_on_item_status_id"
    t.index ["loan_period_id"], name: "index_items_on_loan_period_id"
  end

  create_table "letters", force: :cascade do |t|
    t.string "send_option"
    t.text "recipient"
    t.integer "library_id"
    t.text "message"
    t.datetime "sent_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
    t.string "from"
    t.index ["library_id"], name: "index_letters_on_library_id"
  end

  create_table "letters_semesters", id: false, force: :cascade do |t|
    t.integer "letter_id", null: false
    t.integer "semester_id", null: false
    t.index ["letter_id", "semester_id"], name: "index_letters_semesters_on_letter_id_and_semester_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "loan_periods", force: :cascade do |t|
    t.string "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "use"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semesters", force: :cascade do |t|
    t.string "semester"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
