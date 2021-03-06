# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_19_174705) do

  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "description"
    t.string "justifications"
    t.string "code"
    t.string "additional_links"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "job_id", null: false
    t.boolean "offer_given"
    t.index ["job_id"], name: "index_applications_on_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "position"
    t.string "description"
    t.string "requirements"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "applications", "jobs"
end
