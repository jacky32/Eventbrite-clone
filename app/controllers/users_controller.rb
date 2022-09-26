class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    user
    @organised_events = Event.where(organiser_id: user.id)
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
