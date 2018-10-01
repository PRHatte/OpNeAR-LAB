# == Schema Information
#
# Table name: optical_alarm
#
#  node_id         :integer          not null
#  aid             :string(100)      not null
#  mod2            :string(10)       not null
#  alarm_name      :string(100)      not null
#  start_date      :date             not null
#  start_time      :time             not null
#  chassis_id      :integer
#  slot_id         :integer
#  port_id         :integer
#  severity        :integer
#  severice_affect :integer
#  direction       :integer
#  location        :integer
#  description     :string(100)
#  aid_detail      :string(100)
#  end_date        :date
#  end_time        :time
#

require 'test_helper'

class OpticalAlarmTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
