# The users controller has the dashboard for the current users, a search page for admins, and permission updating.
# 
# An important note is that the search page does a like query for substring searching. 
# The dashboard could is not that heavy at all, it just queries a bunch of different tables, 
# but it is all fairly light

class UsersController < ApplicationController
  before_action :require_signed_in!
  before_action :require_admin!, only: :update

  # Search page.
  def index
    @users = nil

    if params[:q]
      @users = User.where("email LIKE ? ", "%#{params[:q]}%")
    else
      @users = User.all
    end

    @users = @users.page(params[:page] || 1)
  end

  # Permission updating
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to user_path(@user), flash: { notice: 'You successfully updated the user' }
    else
      redirect_to user_path(@user), flash: { error: 'Something went wrong, please check the logs' }
    end
  end

  # Dashboard method
  def show
    @user = User.find(params[:id])
    @hosts = @user.hosts
    @flows = @user.flows.unapproved
    @scheduled_flows = @user.flows.scheduled.or(@user.flows.pending)
    @denied_flows = @user.flows.denied
  end

  private

  def user_params
    params.require(:user).permit(:email, :permission_level)
  end
end