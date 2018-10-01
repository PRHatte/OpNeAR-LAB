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

ActiveRecord::Schema.define(version: 20170413223753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "communication_table", force: :cascade do |t|
    t.integer "optical_node_id"
    t.integer "ethernet_node_id"
    t.integer "table_connection_id"
  end

  create_table "ethernet_nodes", force: :cascade do |t|
    t.integer "node_id"
    t.string  "node_idname"
    t.string  "node_name"
    t.string  "node_ip"
    t.integer "node_type"
    t.string  "node_version"
    t.string  "node_controller"
  end

  create_table "flows", force: :cascade do |t|
    t.integer  "ext_flow_id"
    t.string   "title"
    t.string   "dst"
    t.string   "src"
    t.integer  "status"
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal  "min_bandwidth"
    t.decimal  "max_bandwidth"
    t.string   "bandwidth_unit"
    t.integer  "latency"
    t.string   "method"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.decimal  "bw"
    t.decimal  "duration"
    t.decimal  "startt"
    t.integer  "user_id"
    t.index ["ext_flow_id"], name: "index_flows_on_ext_flow_id", unique: true, using: :btree
  end

  create_table "hosts", primary_key: "host_id", id: :integer, default: -> { "nextval('host_seq'::regclass)" }, force: :cascade do |t|
    t.integer "node_id",                     null: false
    t.string  "host_name",       limit: 100, null: false
    t.string  "host_hwaddress",  limit: 100, null: false
    t.integer "host_segment",                null: false
    t.string  "node_controller", limit: 100
  end

  create_table "ofethernet_link", primary_key: "link_id", id: :integer, default: -> { "nextval('ofethernetlink_seq'::regclass)" }, force: :cascade do |t|
    t.integer "source_port_id", null: false
    t.integer "des_port_id",    null: false
    t.integer "link_cost",      null: false
    t.float   "distance",       null: false
    t.float   "loss",           null: false
    t.integer "capacity",       null: false
  end

  create_table "ofethernet_node", primary_key: "node_id", id: :integer, default: -> { "nextval('ethernetnode_seq'::regclass)" }, force: :cascade do |t|
    t.integer "node_dpid",                   null: false
    t.string  "node_name",       limit: 100, null: false
    t.integer "node_type",                   null: false
    t.integer "node_segment",                null: false
    t.string  "node_controller", limit: 100
  end

  create_table "ofethernet_port", primary_key: "port_id", id: :integer, default: -> { "nextval('ethport_seq'::regclass)" }, force: :cascade do |t|
    t.integer "node_id",                       null: false
    t.integer "port_number",                   null: false
    t.string  "port_hwaddress",    limit: 100, null: false
    t.integer "port_maxspeed",                 null: false
    t.integer "port_currentspeed",             null: false
    t.string  "port_name",         limit: 100, null: false
  end

  create_table "optical_alarm", primary_key: "node_autoid", force: :cascade do |t|
    t.integer "node_id",                     null: false
    t.string  "aid",             limit: 100, null: false
    t.string  "mod2",            limit: 10,  null: false
    t.string  "alarm_name",      limit: 100
    t.date    "start_date"
    t.time    "start_time"
    t.integer "chassis_id"
    t.integer "slot_id"
    t.integer "port_id"
    t.integer "severity"
    t.integer "severice_affect"
    t.integer "direction"
    t.integer "location"
    t.string  "description",     limit: 100
    t.string  "aid_detail",      limit: 100
    t.date    "end_date"
    t.time    "end_time"
  end

  create_table "optical_card", primary_key: ["node_id", "chassis_id", "slot_id"], force: :cascade do |t|
    t.integer "node_id",                null: false
    t.integer "rack_id",                null: false
    t.integer "chassis_id",             null: false
    t.integer "slot_id",                null: false
    t.integer "card_type",              null: false
    t.string  "card_name",  limit: 100, null: false
    t.boolean "edfa_flag",              null: false
  end

  create_table "optical_cards", force: :cascade do |t|
    t.integer "node_id"
    t.integer "rack_id"
    t.integer "chassis_id"
    t.integer "slot_id"
    t.integer "card_type"
    t.string  "card_name"
    t.boolean "EDFA_FLAG"
  end

  create_table "optical_crosslayerlink", primary_key: "crosslayer_link_id", id: :integer, default: -> { "nextval('cross_seq'::regclass)" }, force: :cascade do |t|
    t.integer "l2_port_id", null: false
    t.integer "l0_node",    null: false
    t.integer "l0_chassis", null: false
    t.integer "l0_slot",    null: false
    t.integer "l0_port",    null: false
  end

  create_table "optical_edfa", primary_key: ["node_id", "chassis_id", "slot_id", "edfa_direction"], force: :cascade do |t|
    t.integer "node_id",        null: false
    t.integer "chassis_id",     null: false
    t.integer "slot_id",        null: false
    t.integer "edfa_direction", null: false
    t.integer "edfa_type",      null: false
    t.float   "setgain",        null: false
    t.float   "inputpower",     null: false
    t.float   "outputpower",    null: false
    t.integer "link_type",      null: false
    t.float   "distance",       null: false
    t.float   "loss",           null: false
    t.integer "fiber_type",     null: false
    t.integer "capacity",       null: false
  end

  create_table "optical_edfaspectrum", primary_key: ["node_id", "chassis_id", "slot_id", "edfa_direction"], force: :cascade do |t|
    t.integer "node_id",        null: false
    t.integer "chassis_id",     null: false
    t.integer "slot_id",        null: false
    t.integer "edfa_direction", null: false
    t.float   "frequency",      null: false
    t.float   "power",          null: false
  end

  create_table "optical_link", primary_key: "link_id", id: :integer, force: :cascade do |t|
    t.integer "source_node_id",                null: false
    t.integer "source_chassis_id",             null: false
    t.integer "source_slot_id",                null: false
    t.integer "source_port_id",                null: false
    t.integer "des_node_id",                   null: false
    t.integer "des_chassis_id",                null: false
    t.integer "des_slot_id",                   null: false
    t.integer "des_port_id",                   null: false
    t.string  "link_idname",       limit: 100, null: false
    t.integer "link_type",                     null: false
    t.float   "distance"
    t.float   "loss"
    t.string  "fiber_type",        limit: 100
    t.integer "capacity"
  end

  create_table "optical_node", primary_key: "node_id", id: :integer, force: :cascade do |t|
    t.string  "node_idname",     limit: 100, null: false
    t.string  "node_name",       limit: 100, null: false
    t.string  "node_ip",         limit: 100, null: false
    t.integer "node_type",                   null: false
    t.string  "node_version",    limit: 100, null: false
    t.string  "node_controller", limit: 100
  end

  create_table "optical_nodes", force: :cascade do |t|
    t.integer "node_id"
    t.string  "node_idname"
    t.string  "node_name"
    t.string  "node_ip"
    t.integer "node_type"
    t.string  "node_version"
    t.string  "node_controller"
  end

  create_table "optical_port", primary_key: ["node_id", "chassis_id", "slot_id", "port_id"], force: :cascade do |t|
    t.integer "node_id",                       null: false
    t.integer "rack_id",                       null: false
    t.integer "chassis_id",                    null: false
    t.integer "slot_id",                       null: false
    t.integer "port_id",                       null: false
    t.integer "port_type",                     null: false
    t.integer "port_servicestate"
    t.string  "port_idname",       limit: 100, null: false
    t.integer "port_servicetype"
    t.float   "frequency"
  end

  create_table "optical_trail", primary_key: "trail_id", id: :integer, force: :cascade do |t|
    t.string  "trail_idname",      limit: 100, null: false
    t.string  "trail_name",        limit: 100, null: false
    t.integer "trail_type",                    null: false
    t.integer "source_node_id",                null: false
    t.integer "source_chassis_id",             null: false
    t.integer "source_slot_id",                null: false
    t.integer "source_port_id",                null: false
    t.integer "des_node_id",                   null: false
    t.integer "des_chassis_id",                null: false
    t.integer "des_slot_id",                   null: false
    t.integer "des_port_id",                   null: false
    t.integer "hops",                          null: false
  end

  create_table "optical_trailhops", primary_key: ["trail_id", "link_sequence"], force: :cascade do |t|
    t.integer "trail_id",      null: false
    t.integer "link_sequence", null: false
    t.integer "link_id",       null: false
  end

  create_table "user_host_links", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "host_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id", "user_id"], name: "index_user_host_links_on_host_id_and_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "permission_level"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "hosts", "ofethernet_node", column: "node_id", primary_key: "node_id", name: "fk_ofethernet_hostid"
  add_foreign_key "hosts", "ofethernet_node", column: "node_id", primary_key: "node_id", name: "hosts_node_id_fkey"
  add_foreign_key "ofethernet_link", "ofethernet_port", column: "des_port_id", primary_key: "port_id", name: "fk_ofethernet_destination_portid"
  add_foreign_key "ofethernet_link", "ofethernet_port", column: "des_port_id", primary_key: "port_id", name: "ofethernet_link_des_port_id_fkey"
  add_foreign_key "ofethernet_link", "ofethernet_port", column: "source_port_id", primary_key: "port_id", name: "fk_ofethernet_source_portid"
  add_foreign_key "ofethernet_link", "ofethernet_port", column: "source_port_id", primary_key: "port_id", name: "ofethernet_link_source_port_id_fkey"
  add_foreign_key "ofethernet_port", "ofethernet_node", column: "node_id", primary_key: "node_id", name: "fk_ofethernet_portid"
  add_foreign_key "ofethernet_port", "ofethernet_node", column: "node_id", primary_key: "node_id", name: "ofethernet_port_node_id_fkey"
  add_foreign_key "optical_alarm", "optical_node", column: "node_id", primary_key: "node_id", name: "optical_alarm_node_id_fkey"
  add_foreign_key "optical_alarm", "optical_port", column: "node_id", primary_key: "node_id", name: "fk_alarm_portid"
  add_foreign_key "optical_card", "optical_node", column: "node_id", primary_key: "node_id", name: "optical_card_node_id_fkey"
  add_foreign_key "optical_crosslayerlink", "ofethernet_port", column: "l2_port_id", primary_key: "port_id", name: "fk_ethernet_crosslayerlink"
  add_foreign_key "optical_crosslayerlink", "ofethernet_port", column: "l2_port_id", primary_key: "port_id", name: "optical_crosslayerlink_l2_port_id_fkey"
  add_foreign_key "optical_crosslayerlink", "optical_port", column: "l0_node", primary_key: "node_id", name: "fk_optical_crosslayerlink"
  add_foreign_key "optical_edfa", "optical_card", column: "node_id", primary_key: "node_id", name: "fk_optical_edfa"
  add_foreign_key "optical_edfaspectrum", "optical_card", column: "node_id", primary_key: "node_id", name: "fk_optical_edfa"
  add_foreign_key "optical_edfaspectrum", "optical_node", column: "node_id", primary_key: "node_id", name: "optical_edfaspectrum_node_id_fkey"
  add_foreign_key "optical_link", "optical_port", column: "des_node_id", primary_key: "node_id", name: "fk_optical_destination_portid"
  add_foreign_key "optical_link", "optical_port", column: "source_node_id", primary_key: "node_id", name: "fk_optical_source_portid"
  add_foreign_key "optical_port", "optical_card", column: "node_id", primary_key: "node_id", name: "fk_optical_cardid"
  add_foreign_key "optical_port", "optical_node", column: "node_id", primary_key: "node_id", name: "optical_port_node_id_fkey"
  add_foreign_key "optical_trail", "optical_port", column: "des_node_id", primary_key: "node_id", name: "fk_optical_destination_portid"
  add_foreign_key "optical_trail", "optical_port", column: "source_node_id", primary_key: "node_id", name: "fk_optical_source_portid"
  add_foreign_key "optical_trailhops", "optical_link", column: "link_id", primary_key: "link_id", name: "optical_trailhops_link_id_fkey"
  add_foreign_key "optical_trailhops", "optical_trail", column: "trail_id", primary_key: "trail_id", name: "optical_trailhops_trail_id_fkey"
end
