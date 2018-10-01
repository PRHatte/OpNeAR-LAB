# Whenever an admin needs to look up the alarms. 
# 
# Alarms as they stand are read only. You cannot create on from this web portal.

class OpticalAlarmsController < ApplicationController
  before_action :require_signed_in!
  
  def index # http GET
    # Get two lists, one of ongoing alarms that don't have an end date, and old alarms that have ended
    @ongoing_alarms = OpticalAlarm.where("end_date IS NULL").order(severity: :asc)
    @old_alarms = OpticalAlarm.where("end_date IS NOT NULL").order(end_date: :desc)

    # We need to combine these for the HTML. It's easier to do here
    @added_alarms = @ongoing_alarms + @old_alarms
  end

  def show # http GET
    # This will show one record
    @alarm = OpticalAlarm.find(params[:id])
  end

  private

  def alarm_params
    params.require(:optical_alarm).permit!
  end
end