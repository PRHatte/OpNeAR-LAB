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

class OpticalAlarm < ApplicationRecord
  self.table_name = 'optical_alarm'
  self.primary_key = 'node_autoid'

  def english_severity
    case self.severity
    when 0
      "CR"
    when 1
      "MJ"
    when 2
      "MN"
    else
      "CL"
    end
  end

  def english_severice_affect
    case self.severice_affect
    when 0
      "NSA"
    else
      "SA"
    end
  end

  def english_direction
    case self.direction
    when 0
      "BTH"
    when 1
      "RCV"
    else
      "NA"
    end
  end

  def english_location
    case self.location
    when 0
      "FEND"
    else
      "NEND"
    end
  end

  def color_for_severity
  	case self.severity
  	when 0 
  		"danger"
  	when 1
  		"danger"
  	when 2
  		"warning"
  	else
  		"warning"
  	end
  end
end
