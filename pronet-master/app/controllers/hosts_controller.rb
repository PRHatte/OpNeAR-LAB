# This class has all the routes for administrating the hosts. Authorizing users to use hosts will be done through here.
class HostsController < ApplicationController
  before_action :require_admin! # requires at least admin privileges
 
  def index
    @hosts = Pronet::Host.all
  end

  def show
    @host = Pronet::Host.find(params[:id])

    @authorized_users = @host.users
    @unautorized_users = User.where.not(id: @authorized_users)
  end

  def authorize
    # Warning: This method is not thread/process safe. Consider including a locking library
    @host = Pronet::Host.find(params[:id])
    @user = User.find(params[:user_id])

    @host_link = UserHostLink.new(host_id: @host.id, user_id: @user.id)
    if @host_link.save
      redirect_to host_path(@host), flash: { notice: "User successfully authorized." }
    else
      redirect_to host_path(@host), flash: { error: "Something went wrong when authorizing this user. Please check the logs." }
    end
  end

  def deauthorize
    # Warning: This method is not thread/process safe. Consider including a locking library
    @host = Pronet::Host.find(params[:id])
    @user = User.find(params[:user_id])

    @host_link = UserHostLink.where(host_id: @host.id, user_id: @user.id).take # taking the first one.

    if @host_link.destroy
      redirect_to host_path(@host), flash: { notice: "User successfully deauthorized." }
    else
      redirect_to host_path(@host), flash: { error: "Something went wrong when deauthorizing this user. Please check the logs." }
    end
  end
end