# The flow controller holds all the methods related to flows. 

class FlowsController < ApplicationController
  # Filter documentations http://guides.rubyonrails.org/action_controller_overview.html#filters
  before_action :require_signed_in!

  def index
    @flows = Flow.all
  end

  def show
    @flow = Flow.find(params[:id])
  end

  def new
    @flow = Flow.new
    @hosts = current_user.hosts
  end

  def create
    @flow = current_user.flows.build(flow_params)
    @hosts = current_user.hosts


    if @flow.save
      redirect_to user_path(current_user)
    else
      render 'new' # render the form inside this action, this allows the errors on the form to be populated
    end
  end

  def edit
    @flow = current_user.flows.find(params[:id])
    @hosts = current_user.hosts
  end

  def update
    @flow = current_user.flows.find(params[:id])
    if @flow.update_attributes(flow_params)
      redirect_to user_path(current_user)
    else
      render 'edit' # render the form inside this action, this allows the errors on the form to be populated
    end
  end

  def destroy
    @flow = Flow.find(params[:id])
    @flow.destroy
    redirect_to user_path(current_user)
  end

  def advance
    @flow = Flow.find(params[:id])

    if @flow.update_attributes(status: params[:status])
      redirect_to flows_path, flash: { notice: "Flow has been set to status #{@flow.english_status}." }
    else
      redirect_to flows_path, flash: { notice: "Flow was unable to be set. Please contact an admininstrator." }
    end
  end

  private

  def flow_params
    params.require(:flow).permit(:title, :src, :dst, :method, :start_time, :end_time, :min_bandwidth, :max_bandwidth, :bandwidth_unit, :latency, :bw, :duration, :startt, :user_id)
  end
end
