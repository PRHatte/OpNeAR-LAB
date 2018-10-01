# == Schema Information
#
# Table name: optical_port
#
#  node_id           :integer          not null
#  rack_id           :integer          not null
#  chassis_id        :integer          not null
#  slot_id           :integer          not null
#  port_id           :integer          not null
#  port_type         :integer          not null
#  port_servicestate :integer
#  port_idname       :string(100)      not null
#  port_servicetype  :integer
#  central_frequency :float
#  optical_width     :integer
#  flexitu_n         :integer
#  flexitu_m         :integer
#

module Pronet
  class OpticalPort < ApplicationRecord
    self.table_name = "optical_port"
  end
end
