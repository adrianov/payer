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

ActiveRecord::Schema.define(version: 2020_02_12_204521) do

  create_table "payouts", force: :cascade do |t|
    t.datetime "dt", precision: 0, null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.string "phone", null: false
    t.string "client", null: false
    t.integer "destination", null: false
    t.string "receiver_fio", null: false
    t.string "response_payout"
    t.string "response_check"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
