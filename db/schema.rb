# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_210_206_204_242) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'
  enable_extension 'postgis'

  create_table 'partners', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'trading_name', null: false
    t.string 'owner_name', null: false
    t.string 'document', null: false
    t.geometry 'coverage_area', limit: { srid: 0, type: 'multi_polygon' }, null: false
    t.geometry 'address', limit: { srid: 0, type: 'st_point' }, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['document'], name: 'index_partners_on_document', unique: true
  end
end
