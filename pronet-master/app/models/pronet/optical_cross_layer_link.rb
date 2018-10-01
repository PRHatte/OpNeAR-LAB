# == Schema Information
#
# Table name: optical_crosslayerlink
#
#  l2_hw_addr :string(100)      not null, primary key
#  l0_node    :integer          not null
#  l0_chassis :integer          not null
#  l0_slot    :integer          not null
#  l0_port    :integer          not null
#

module Pronet
  class OpticalCrossLayerLink < ApplicationRecord
    self.table_name = "optical_crosslayerlink"
  end
end

