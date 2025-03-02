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

ActiveRecord::Schema[8.0].define(version: 2025_03_02_115803) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "employee_time_logs", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.datetime "clock_in"
    t.datetime "clock_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_time_logs_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "hiring_date"
    t.string "job_title"
    t.boolean "active"
    t.string "employment_status"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jsas", force: :cascade do |t|
    t.string "job_description"
    t.date "date"
    t.string "location"
    t.string "facilitator"
    t.string "marathon_rep"
    t.string "safety_rep"
    t.string "work_crew_supervisor"
    t.text "critical_steps"
    t.text "potential_hazards"
    t.text "safety_measures"
    t.text "procedures_reviewed"
    t.text "worst_case"
    t.text "special_tools"
    t.string "potential_hazard_key", default: [], array: true
    t.string "required_ppe", default: [], array: true
    t.string "required_protection_key", default: [], array: true
    t.string "body_part_key", default: [], array: true
    t.string "training_required", default: [], array: true
    t.string "mobile_equipment", default: [], array: true
    t.string "other_inspections", default: [], array: true
    t.string "employee_name"
    t.string "initials"
    t.date "submission_date"
    t.time "submission_time"
    t.string "foreman_signature"
    t.string "operations_signature"
    t.string "safety_rep_signature"
    t.date "audit_date"
    t.date "signature_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_logs", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.datetime "clock_in"
    t.datetime "clock_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_time_logs_on_employee_id"
  end

  add_foreign_key "employee_time_logs", "employees"
  add_foreign_key "time_logs", "employees"
end
