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

ActiveRecord::Schema[8.0].define(version: 2026_07_27_220021) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "color"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "entries", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.integer "category_id", null: false
    t.string "subtype"
    t.string "level", default: "basico", null: false
    t.string "kind", default: "animated", null: false
    t.text "intuition"
    t.string "complexity"
    t.string "viz"
    t.text "body"
    t.text "code_snippets"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "slug"], name: "index_entries_on_category_id_and_slug", unique: true
    t.index ["category_id"], name: "index_entries_on_category_id"
  end

  add_foreign_key "entries", "categories"
end
