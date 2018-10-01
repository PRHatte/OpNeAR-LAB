# == Schema Information
#
# Table name: ofethernet_node
#
#  node_id         :integer          not null, primary key
#  node_dpid       :integer          not null
#  node_name       :string(100)      not null
#  node_type       :integer          not null
#  node_segment    :integer          not null
#  node_controller :string(100)
#

module Pronet
  class OfethernetNode < ApplicationRecord
    self.table_name = "ofethernet_node"
    self.primary_key = "node_id"
  end
end
