# == Schema Information
#
# Table name: optical_link
#
#  link_id               :integer          not null, primary key
#  source_node_id        :integer          not null
#  source_node_direction :string(1)        not null
#  des_node_id           :integer          not null
#  des_node_direction    :string(1)        not null
#  link_idname           :string(100)      not null
#  link_type             :integer          not null
#  distance              :float
#  loss                  :float
#  fiber_type            :string(100)
#  apc_domainid          :integer
#

module Pronet
  class OpticalLink < ApplicationRecord
    self.table_name = "optical_link"
  end
end
