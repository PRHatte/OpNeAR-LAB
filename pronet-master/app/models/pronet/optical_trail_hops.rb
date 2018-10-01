# == Schema Information
#
# Table name: optical_trailhops
#
#  trail_id      :integer          not null
#  link_sequence :integer          not null
#  link_id       :integer          not null
#

module Pronet
  class OpticalTrailHops < ApplicationRecord
    self.table_name = "optical_trailhops"
  end
end
