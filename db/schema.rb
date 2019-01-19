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

ActiveRecord::Schema.define(version: 2019_01_19_182800) do

  create_table "answeredexercises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "answered"
    t.boolean "correct"
    t.bigint "exercise_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_answeredexercises_on_exercise_id"
    t.index ["user_id"], name: "index_answeredexercises_on_user_id"
  end

  create_table "answeredquizzs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "generatedquizz_id"
    t.decimal "note", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["generatedquizz_id"], name: "index_answeredquizzs_on_generatedquizz_id"
    t.index ["user_id"], name: "index_answeredquizzs_on_user_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "exercise_id"
    t.index ["exercise_id"], name: "index_comments_on_exercise_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conceptualmodels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "url"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_conceptualmodels_on_user_id"
  end

  create_table "exercises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "statement"
    t.text "solution"
    t.boolean "public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "generatedquizzs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "quizz_id"
    t.string "code"
    t.index ["quizz_id"], name: "index_generatedquizzs_on_quizz_id"
    t.index ["user_id"], name: "index_generatedquizzs_on_user_id"
  end

  create_table "joinanswereds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "answeredexercise_id"
    t.bigint "answeredquizz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answeredexercise_id"], name: "index_joinanswereds_on_answeredexercise_id"
    t.index ["answeredquizz_id"], name: "index_joinanswereds_on_answeredquizz_id"
  end

  create_table "quizzexercises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "exercise_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_quizzexercises_on_exercise_id"
    t.index ["user_id"], name: "index_quizzexercises_on_user_id"
  end

  create_table "quizzs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.boolean "public"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_quizzs_on_user_id"
  end

  create_table "topicexercises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "topic_id"
    t.bigint "exercise_id"
    t.index ["exercise_id"], name: "index_topicexercises_on_exercise_id"
    t.index ["topic_id"], name: "index_topicexercises_on_topic_id"
  end

  create_table "topics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
  end

  add_foreign_key "answeredexercises", "exercises"
  add_foreign_key "answeredexercises", "users"
  add_foreign_key "answeredquizzs", "generatedquizzs"
  add_foreign_key "answeredquizzs", "users"
  add_foreign_key "comments", "exercises"
  add_foreign_key "comments", "users"
  add_foreign_key "conceptualmodels", "users"
  add_foreign_key "exercises", "users"
  add_foreign_key "generatedquizzs", "quizzs"
  add_foreign_key "generatedquizzs", "users"
  add_foreign_key "joinanswereds", "answeredexercises"
  add_foreign_key "joinanswereds", "answeredquizzs"
  add_foreign_key "quizzexercises", "exercises"
  add_foreign_key "quizzexercises", "users"
  add_foreign_key "quizzs", "users"
  add_foreign_key "topicexercises", "exercises"
  add_foreign_key "topicexercises", "topics"
end
