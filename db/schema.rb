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

ActiveRecord::Schema[7.0].define(version: 2024_12_08_180135) do
  create_table "answers", force: :cascade do |t|
    t.integer "question_id", null: false
    t.text "text_value"
    t.integer "numerical_value"
    t.integer "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "communications", force: :cascade do |t|
    t.integer "patient_id"
    t.text "content"
    t.integer "channel", null: false
    t.integer "sentiment"
    t.float "response_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_communications_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.integer "personality_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_patients_on_email", unique: true
    t.index ["personality_type_id"], name: "index_patients_on_personality_type_id"
  end

  create_table "personality_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_options", force: :cascade do |t|
    t.integer "question_id", null: false
    t.string "field_value"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer "questionnaire_id", null: false
    t.string "content"
    t.string "field_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "retention_rates", force: :cascade do |t|
    t.integer "personality_type_id"
    t.integer "month"
    t.float "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personality_type_id"], name: "index_retention_rates_on_personality_type_id"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "communications", "patients"
  add_foreign_key "patients", "personality_types"
  add_foreign_key "question_options", "questions"
  add_foreign_key "questions", "questionnaires"
  add_foreign_key "retention_rates", "personality_types"
end
