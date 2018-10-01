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

ActiveRecord::Schema.define(version: 20170221205803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flows", force: :cascade do |t|
    t.string   "title"
    t.string   "destination"
    t.string   "source"
    t.integer  "status"
    t.datetime "time_reserved"
    t.decimal  "min_bandwidth"
    t.decimal  "max_bandwidth"
    t.string   "bandwidth_unit"
    t.integer  "latency"
    t.string   "method"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end
  
  
  create_table "optical_nodes", force: :cascade do |on|
  on.integer   "node_id",     null: false
  on.string    "node_idname",     null: false
  on.string    "node_name",     null: false
  on.string    "node_ip",     null: false
  on.integer   "node_type",     null: false
  on.string    "node_version",     null: false
  on.string    "node_controller",     null: true
  #PRIMARY KEY (node_id)
  execute "ALTER TABLE employees ADD PRIMARY KEY (node_id);"
  end

  #basically a copy of optical_nodes
  create_table "ethernet_nodes", force: :cascade do |on|
  on.integer   "node_id",     null: false
  on.string    "node_idname",     null: false
  on.string    "node_name",     null: false
  on.string    "node_ip",     null: false
  on.integer   "node_type",     null: false
  on.string    "node_version",     null: false
  on.string    "node_controller",     null: true
  #PRIMARY KEY (node_id)
  execute "ALTER TABLE employees ADD PRIMARY KEY (node_id);"
  end
  
  #there may be an extra table for virtual_ethernet_nodes
  
  
  create_table "Communication table", force: :cascade do |on|
  on.integer   "optical_node_id",     null: false
  on.integer   "ethernet_node_id",     null: false
  on.integer   "table_connection_id",     null: false
  #belongs_to is somewhere here because they are both foreign keys 
  #http://guides.rubyonrails.org/association_basics.html
  #PRIMARY KEY (node_id)
  execute "ALTER TABLE employees ADD PRIMARY KEY (table_connection_id);"
  end
  
  
  create_table "optical_cards", force: :cascade do |oc|
  oc.integer   "node_id",     null: false
  oc.integer   "rack_id",     null: false
  oc.integer   "chassis_id",     null: false
  oc.integer   "slot_id",     null: false
  oc.integer   "card_type",     null: false
  oc.string    "card_name",     null: false
  oc.boolean   "EDFA_FLAG",     null: false
  #PRIMARY KEY (node_id,chassis_id, slot_id)
  execute "ALTER TABLE employees ADD PRIMARY KEY (node_id);"
  execute "ALTER TABLE employees ADD PRIMARY KEY (chassis_id);"
  execute "ALTER TABLE employees ADD PRIMARY KEY (slot_id);"
  end

  #http://stackoverflow.com/questions/1200568/using-rails-how-can-i-set-my-primary-key-to-not-be-an-integer-typed-column
end
