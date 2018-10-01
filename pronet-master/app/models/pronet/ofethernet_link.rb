# == Schema Information
#
# Table name: ofethernet_link
#
#  link_id        :integer          not null, primary key
#  source_port_id :integer          not null
#  des_port_id    :integer          not null
#  link_cost      :integer          not null
#  distance       :float            not null
#  loss           :float            not null
#  capacity       :integer          not null
#

module Pronet
  class OfethernetLink < ApplicationRecord
    self.table_name = "ofethernet_link"
    self.primary_key = "link_id"
  end
end
