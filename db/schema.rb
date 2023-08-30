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

ActiveRecord::Schema[7.0].define(version: 2023_08_23_124431) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "journals", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.integer "date"
    t.text "content"
    t.text "goals_today"
    t.text "goals_tomorrow"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_journals_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "user_id"
    t.string "task_name"
    t.text "description"
    t.integer "date"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname", null: false
    t.string "lastname"
    t.integer "employee_id"
    t.date "date_of_birth"
    t.date "joining_day"
    t.string "designation", limit: 50
    t.binary "profile_picture"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
