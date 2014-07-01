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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140701004944) do

  create_table "actions", force: true do |t|
    t.text     "subject"
    t.text     "predicate"
    t.text     "complements"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adjectives", force: true do |t|
    t.string   "aggettivo"
    t.string   "classe"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bonds", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "concetto_1_id"
    t.integer  "concetto_2_id"
    t.string   "tipo"
  end

  create_table "concepts", force: true do |t|
    t.integer  "concept_id"
    t.integer  "noun_id"
    t.text     "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concepts", ["concept_id"], name: "index_concepts_on_concept_id"
  add_index "concepts", ["noun_id"], name: "index_concepts_on_noun_id"

  create_table "locutions", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "author"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nouns", force: true do |t|
    t.string   "nome"
    t.string   "definizione"
    t.string   "genere"
    t.integer  "noun_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nouns", ["noun_id"], name: "index_nouns_on_noun_id"

  create_table "verbs", force: true do |t|
    t.string   "infinito"
    t.string   "prima_persona_singolare"
    t.string   "seconda_persona_singolare"
    t.string   "terza_persona_singolare"
    t.string   "prima_persona_plurale"
    t.string   "seconda_persona_plurale"
    t.string   "terza_persona_plurale"
    t.string   "participio_passato"
    t.string   "ausiliare"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "method"
  end

end
