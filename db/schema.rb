ActiveRecord::Schema.define(version: 20171001194703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "original_text"
    t.string "translated_text"
    t.date "review_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
