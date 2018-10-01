# == Schema Information
#
# Table name: ofethernet_port
#
#  port_id           :integer          not null, primary key
#  node_id           :integer          not null
#  port_number       :integer          not null
#  port_hwaddress    :string(100)      not null
#  port_maxspeed     :integer          not null
#  port_currentspeed :integer          not null
#  port_name         :string(100)      not null
#

module Pronet
  class OfethernetPort < ApplicationRecord
    self.table_name = "ofethernet_port"
  end
end
