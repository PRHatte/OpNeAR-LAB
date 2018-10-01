# == Schema Information
#
# Table name: optical_node
#
#  node_id         :integer          not null, primary key
#  node_idname     :string(100)      not null
#  node_name       :string(100)      not null
#  node_ip         :string(100)      not null
#  node_type       :integer          not null
#  node_version    :string(100)      not null
#  node_controller :string(100)
#

module Pronet
  class OpticalNode < ApplicationRecord
    self.table_name = "optical_node"
  end
end
