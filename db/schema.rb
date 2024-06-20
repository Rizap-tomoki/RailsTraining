# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_06_20_071036) do
  create_table "departments", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_departments_on_name"
  end

  create_table "skills", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skills_on_name"
  end

  create_table "skills_users", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "user_id"
    t.index ["skill_id", "user_id"], name: "index_skills_users_on_skill_id_and_user_id", unique: true
    t.index ["skill_id"], name: "index_skills_users_on_skill_id"
    t.index ["user_id"], name: "index_skills_users_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hiragana_nama"
    t.string "sex"
    t.string "tel"
    t.string "mobile"
    t.string "mail"
    t.string "postcode"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "address4"
    t.string "address5"
    t.date "birthday"
    t.bigint "department_id"
    t.binary "image"
    t.string "password_digest"
    t.index ["address1"], name: "index_users_on_address1"
    t.index ["birthday"], name: "index_users_on_birthday"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["mail"], name: "index_users_on_mail", unique: true
  end

  add_foreign_key "users", "departments"
end
