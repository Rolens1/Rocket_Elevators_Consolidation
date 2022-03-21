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

ActiveRecord::Schema.define(version: 2022_03_17_232104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dim_customers", force: :cascade do |t|
    t.datetime "createdOn"
    t.string "companyName"
    t.string "fullNameOfMainContact"
    t.string "emailOfMainContact"
    t.integer "nbElevator"
    t.string "customerCity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees_users", id: false, force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "user_id", null: false
    t.string "[:employee_email, :user_email]"
    t.string "[:user_email, :employee_email]"
  end

  create_table "fact_contacts", force: :cascade do |t|
    t.integer "contactId"
    t.datetime "createdOn"
    t.string "companyName"
    t.string "email"
    t.string "projectName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fact_elevators", force: :cascade do |t|
    t.integer "serialNumber"
    t.datetime "dateOfCommissioning"
    t.integer "buildingId"
    t.integer "customerId"
    t.string "buildingCity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fact_quotes", force: :cascade do |t|
    t.integer "quoteId"
    t.datetime "createdOn"
    t.string "companyName"
    t.string "email"
    t.integer "nbElevator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.string "building_type"
    t.string "product_line"
    t.integer "no_of_apartments"
    t.integer "no_of_floors"
    t.integer "no_of_basements"
    t.integer "no_of_businesses"
    t.integer "no_of_parking_spaces"
    t.integer "no_of_elevator_cages"
    t.integer "max_of_occupants_per_floor"
    t.integer "no_of_hours_of_activities"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "no_of_elevators_needed"
    t.integer "unit_price"
    t.integer "total_price_of_elevators"
    t.integer "installation_fees"
    t.integer "final_price"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
