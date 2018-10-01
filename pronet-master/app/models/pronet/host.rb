# == Schema Information
#
# Table name: hosts
#
#  host_id         :integer          not null, primary key
#  node_id         :integer          not null
#  host_name       :string(100)      not null
#  host_hwaddress  :string(100)      not null
#  host_segment    :integer          not null
#  node_controller :string(100)
#

module Pronet
  class Host < ApplicationRecord
    self.table_name = "hosts"

    has_many :user_host_links
    has_many :users, through: :user_host_links, class_name: "User"
  end
end
