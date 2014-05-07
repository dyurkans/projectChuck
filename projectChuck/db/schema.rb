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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140417061207) do

  create_table "brackets", :force => true do |t|
    t.integer  "tournament_id"
    t.boolean  "gender",        :limit => 255
    t.integer  "min_age"
    t.integer  "max_age"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "guardians", :force => true do |t|
    t.integer  "household_id"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "cell_phone"
    t.string   "day_phone"
    t.boolean  "receive_texts",                :default => true
    t.string   "email"
    t.boolean  "gender",        :limit => 255
    t.boolean  "active",                       :default => true
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "households", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "home_phone"
    t.string   "insurance_provider"
    t.string   "insurance_policy_no"
    t.string   "family_physician"
    t.string   "physician_phone"
    t.boolean  "active",              :default => true
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "county"
  end

  create_table "registrations", :force => true do |t|
    t.integer  "student_id"
    t.integer  "team_id"
    t.string   "report_card"
    t.string   "proof_of_insurance"
    t.string   "physical"
    t.date     "physical_date"
    t.integer  "t_shirt_size"
    t.boolean  "active",             :default => true
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "students", :force => true do |t|
    t.integer  "household_id"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "cell_phone"
    t.string   "school"
    t.string   "school_county"
    t.integer  "grade_integer",           :limit => 255
    t.boolean  "gender",                  :limit => 255
    t.string   "emergency_contact_name"
    t.string   "emergency_contact_phone"
    t.string   "birth_certificate"
    t.text     "allergies"
    t.text     "medications"
    t.integer  "security_question",       :limit => 255
    t.string   "security_response"
    t.boolean  "active",                                 :default => true
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "email"
  end

  create_table "teams", :force => true do |t|
    t.integer  "bracket_id"
    t.integer  "name",         :limit => 255
    t.integer  "max_students"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "coach"
  end

  create_table "tournaments", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "password_digest"
    t.string   "email"
    t.string   "role"
    t.boolean  "active",          :default => true
    t.integer  "guardian_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

end
