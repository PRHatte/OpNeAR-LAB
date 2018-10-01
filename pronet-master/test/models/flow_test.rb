# == Schema Information
#
# Table name: flows
#
#  id             :integer          not null, primary key
#  ext_flow_id    :integer
#  title          :string
#  dst            :string
#  src            :string
#  status         :integer
#  start_time     :datetime
#  end_time       :datetime
#  min_bandwidth  :decimal(, )
#  max_bandwidth  :decimal(, )
#  bandwidth_unit :string
#  latency        :integer
#  method         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  bw             :decimal(, )
#  duration       :decimal(, )
#  startt         :decimal(, )
#  user_id        :integer
#
# Indexes
#
#  index_flows_on_ext_flow_id  (ext_flow_id) UNIQUE
#

require 'test_helper'

class FlowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
