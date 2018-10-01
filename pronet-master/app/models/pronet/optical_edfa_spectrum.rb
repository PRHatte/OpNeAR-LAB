# == Schema Information
#
# Table name: optical_edfaspectrum
#
#  node_id        :integer          not null
#  chassis_id     :integer          not null
#  slot_id        :integer          not null
#  edfa_direction :integer          not null
#  frequency      :float            not null
#  power          :float            not null
#

module Pronet
  class OpticalEdfaSpectrum < ApplicationRecord
    self.table_name = "optical_edfaspectrum"
  end
end
