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

ActiveRecord::Schema.define(:version => 20140112002421) do

  create_table "categories", :force => true do |t|
    t.string   "code",       :null => false
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["code"], :name => "categories_code_uidx", :unique => true

  create_table "categories_games", :force => true do |t|
    t.integer "game_id",     :null => false
    t.integer "category_id", :null => false
  end

  add_index "categories_games", ["category_id"], :name => "categories_games_category_fk"
  add_index "categories_games", ["game_id"], :name => "categories_games_game_fk"

  create_table "comments", :force => true do |t|
    t.text     "body",       :null => false
    t.integer  "user_id",    :null => false
    t.integer  "game_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["game_id"], :name => "comments_game_fk"
  add_index "comments", ["user_id"], :name => "comments_user_fk"

  create_table "games", :force => true do |t|
    t.string   "title",                          :null => false
    t.text     "description",                    :null => false
    t.boolean  "approved",    :default => false, :null => false
    t.integer  "user_id",                        :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "games", ["title"], :name => "games_title_uidx", :unique => true
  add_index "games", ["user_id"], :name => "games_user_fk"

  create_table "images", :force => true do |t|
    t.integer  "user_id",            :null => false
    t.integer  "game_id",            :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "images", ["game_id"], :name => "images_game_fk"
  add_index "images", ["user_id"], :name => "images_user_fk"

  create_table "ranks", :force => true do |t|
    t.integer  "code",       :null => false
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ranks", ["code"], :name => "ranks_code_uidx", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "hashed_password", :null => false
    t.string   "salt"
    t.string   "email",           :null => false
    t.integer  "rank_id",         :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["rank_id"], :name => "users_rank_fk"

  add_foreign_key "categories_games", "categories", :name => "categories_games_category_fk"
  add_foreign_key "categories_games", "games", :name => "categories_games_game_fk"

  add_foreign_key "comments", "games", :name => "comments_game_fk"
  add_foreign_key "comments", "users", :name => "comments_user_fk"

  add_foreign_key "games", "users", :name => "games_user_fk"

  add_foreign_key "images", "games", :name => "images_game_fk"
  add_foreign_key "images", "users", :name => "images_user_fk"

  add_foreign_key "users", "ranks", :name => "users_rank_fk"

end
