# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100422150320) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "brief"
    t.text     "content"
    t.text     "raw_content"
    t.text     "cached_tag_list"
    t.text     "settings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "read_count",        :default => 0
    t.integer  "bit_opt",           :default => 0
    t.integer  "user_id",                          :null => false
    t.integer  "category_id"
    t.string   "permalink"
    t.datetime "last_commented_at"
    t.integer  "rank",              :default => 0
  end

  add_index "articles", ["bit_opt"], :name => "index_articles_on_bit_opt"
  add_index "articles", ["category_id"], :name => "index_articles_on_category_id"
  add_index "articles", ["permalink"], :name => "index_articles_on_permalink"
  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "info"
    t.datetime "created_at"
    t.integer  "position",   :default => 0
    t.integer  "bit_opt",    :default => 0
    t.integer  "user_id"
  end

  add_index "categories", ["bit_opt"], :name => "index_categories_on_bit_opt"
  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "feedbacks", :force => true do |t|
    t.string   "writer"
    t.string   "homepage"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at"
    t.integer  "user_id"
    t.integer  "article_id"
    t.integer  "bit_opt",    :default => 0
    t.string   "user_name"
    t.text     "settings"
    t.string   "audit_by"
    t.string   "ip"
    t.integer  "post_by"
    t.string   "twitter"
  end

  add_index "feedbacks", ["article_id"], :name => "index_comments_on_article_id"
  add_index "feedbacks", ["bit_opt"], :name => "index_comments_on_bit_opt"
  add_index "feedbacks", ["user_id"], :name => "index_comments_on_user_id"

  create_table "groups", :force => true do |t|
    t.string  "name"
    t.integer "space",           :default => 0
    t.integer "file_size_limit", :default => 0
    t.text    "settings"
    t.integer "bit_opt",         :default => 0
  end

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "info"
    t.datetime "created_at"
    t.integer  "user_id"
    t.integer  "position",   :default => 0
    t.integer  "bit_opt",    :default => 0
  end

  add_index "links", ["bit_opt"], :name => "index_links_on_bit_opt"
  add_index "links", ["user_id"], :name => "index_links_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "domain"
    t.string   "default_user"
    t.string   "default_theme"
    t.string   "user_mode"
    t.datetime "created_at"
    t.integer  "default_group"
    t.integer  "bit_opt",       :default => 0
    t.string   "footer"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                          :null => false
    t.string   "nick"
    t.string   "email"
    t.string   "title"
    t.string   "info"
    t.string   "hashed_password"
    t.string   "theme"
    t.text     "settings"
    t.datetime "created_at"
    t.integer  "bit_opt",                       :default => 0
    t.integer  "blog_read",                     :default => 0
    t.integer  "group_id"
    t.integer  "cache_space",                   :default => -1
    t.string   "salt"
    t.string   "bind_domain"
    t.string   "remember_key"
    t.datetime "remember_key_expires_at"
    t.string   "language"
    t.string   "reset_password_key"
    t.datetime "reset_password_key_expires_at"
    t.string   "twitter"
  end

  add_index "users", ["bit_opt"], :name => "index_users_on_bit_opt"
  add_index "users", ["group_id"], :name => "index_users_on_group_id"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["remember_key"], :name => "index_users_on_remember_key"

end
