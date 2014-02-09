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

ActiveRecord::Schema.define(:version => 20140209045407) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "curriculum_definitions", :force => true do |t|
    t.integer  "definition_id"
    t.integer  "curriculum_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "curriculum_definitions", ["curriculum_id"], :name => "index_curriculum_definitions_on_curriculum_id"
  add_index "curriculum_definitions", ["definition_id", "curriculum_id"], :name => "index_curriculum_definitions_on_definition_id_and_curriculum_id", :unique => true
  add_index "curriculum_definitions", ["definition_id"], :name => "index_curriculum_definitions_on_definition_id"

  create_table "curriculum_faves", :force => true do |t|
    t.integer  "curriculum_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "curriculum_faves", ["curriculum_id", "user_id"], :name => "index_curriculum_faves_on_curriculum_id_and_user_id", :unique => true
  add_index "curriculum_faves", ["curriculum_id"], :name => "index_curriculum_faves_on_curriculum_id"
  add_index "curriculum_faves", ["user_id"], :name => "index_curriculum_faves_on_user_id"

  create_table "curriculums", :force => true do |t|
    t.integer  "user_id",                  :null => false
    t.string   "name",                     :null => false
    t.integer  "curriculum_definition_id"
    t.string   "description",              :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "curriculums", ["curriculum_definition_id"], :name => "index_curriculums_on_curriculum_definition_id"
  add_index "curriculums", ["user_id"], :name => "index_curriculums_on_user_id"

  create_table "definition_faves", :force => true do |t|
    t.integer  "definition_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "definition_faves", ["definition_id", "user_id"], :name => "index_definition_faves_on_definition_id_and_user_id", :unique => true
  add_index "definition_faves", ["definition_id"], :name => "index_definition_faves_on_definition_id"
  add_index "definition_faves", ["user_id"], :name => "index_definition_faves_on_user_id"

  create_table "definitions", :force => true do |t|
    t.integer  "word_id",        :null => false
    t.integer  "user_id",        :null => false
    t.text     "body",           :null => false
    t.integer  "subdivision_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "definitions", ["subdivision_id"], :name => "index_definitions_on_subdivision_id"
  add_index "definitions", ["user_id"], :name => "index_definitions_on_user_id"
  add_index "definitions", ["word_id"], :name => "index_definitions_on_word_id"

  create_table "examples", :force => true do |t|
    t.text     "body",          :null => false
    t.integer  "definition_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "examples", ["definition_id"], :name => "index_examples_on_definition_id"

  create_table "messages", :force => true do |t|
    t.string   "subject",                         :null => false
    t.string   "body",                            :null => false
    t.boolean  "read",         :default => false
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "messages", ["recipient_id"], :name => "index_messages_on_recipient_id"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "subdivision_managements", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.integer  "subdivision_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "subdivision_managements", ["subdivision_id"], :name => "index_subdivision_managements_on_subdivision_id"
  add_index "subdivision_managements", ["user_id"], :name => "index_subdivision_managements_on_user_id"

  create_table "subdivisions", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",        :null => false
    t.integer  "definition_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "taggings", ["definition_id"], :name => "index_taggings_on_definition_id"
  add_index "taggings", ["tag_id", "definition_id"], :name => "index_taggings_on_tag_id_and_definition_id", :unique => true
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                    :null => false
    t.string   "password_digest",                          :null => false
    t.integer  "subdivision_id",                           :null => false
    t.string   "session_token",                            :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.boolean  "admin",                 :default => false
    t.string   "forgot_password_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["forgot_password_token"], :name => "index_users_on_forgot_password_token"

  create_table "votes", :force => true do |t|
    t.integer  "vote"
    t.integer  "definition_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votes", ["definition_id", "user_id"], :name => "index_votes_on_definition_id_and_user_id", :unique => true
  add_index "votes", ["definition_id"], :name => "index_votes_on_definition_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

  create_table "words", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "words", ["name"], :name => "index_words_on_name", :unique => true

end
