# == Schema Information
#
# Table name: optical_card
#
#  node_id    :integer          not null
#  rack_id    :integer          not null
#  chassis_id :integer          not null
#  slot_id    :integer          not null
#  card_type  :integer          not null
#  card_name  :string(100)      not null
#  edfa_flag  :integer          not null
#

module Pronet
  class OpticalCard < ApplicationRecord
    self.table_name = "optical_card"
  end
end
