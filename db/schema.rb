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

ActiveRecord::Schema.define(version: 20141212125842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: true do |t|
    t.float    "team_a_avg_point"
    t.float    "team_b_avg_point"
    t.text     "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.float    "point",      default: 2000.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_players", force: true do |t|
    t.integer  "player_id"
    t.integer  "match_id"
    t.string   "team"
    t.float    "current_point"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["match_id"], :name => "fk__match_players_match_id"
    t.index ["player_id"], :name => "fk__match_players_player_id"
    t.foreign_key ["match_id"], "matches", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_match_players_match_id"
    t.foreign_key ["player_id"], "players", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_match_players_player_id"
  end

end
