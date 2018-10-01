# == Schema Information
#
# Table name: optical_trail
#
#  trail_id          :integer          not null, primary key
#  trail_idname      :string(100)      not null
#  trail_name        :string(100)      not null
#  trail_type        :integer          not null
#  source_node_id    :integer          not null
#  source_chassis_id :integer          not null
#  source_slot_id    :integer          not null
#  source_port_id    :integer          not null
#  des_node_id       :integer          not null
#  des_chassis_id    :integer          not null
#  des_slot_id       :integer          not null
#  des_port_id       :integer          not null
#  hops              :integer          not null
#

module Pronet
  class OpticalTrail < ApplicationRecord
    self.table_name = "optical_trail"
  end
end
