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

ActiveRecord::Schema.define(version: 20150503075608) do

  create_table "course_lecture_to_files", force: true do |t|
    t.text     "course_no"
    t.text     "file_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_to_projects", force: true do |t|
    t.text     "course_no"
    t.text     "project_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_to_student_notes", force: true do |t|
    t.text     "course_no"
    t.text     "note"
    t.text     "student_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_to_students", force: true do |t|
    t.text     "course_no"
    t.text     "student_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.text     "name"
    t.text     "no"
    t.text     "teacher_no"
    t.text     "explain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrols", force: true do |t|
    t.text     "student_no"
    t.text     "course_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.text     "student_no"
    t.text     "course_no"
    t.text     "project_no"
    t.text     "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_to_files", force: true do |t|
    t.text     "project_no"
    t.text     "file_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_to_student_notes", force: true do |t|
    t.text     "note"
    t.text     "project_no"
    t.text     "student_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.text     "explain"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", force: true do |t|
    t.text     "name"
    t.text     "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.text     "email"
    t.text     "name"
    t.text     "password"
    t.text     "profil_image"
    t.text     "student_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.text     "email"
    t.text     "name"
    t.text     "password"
    t.text     "profil_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temps", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: true do |t|
    t.text     "student_no"
    t.text     "course_no"
    t.text     "project_no"
    t.text     "file_name"
    t.text     "file_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
