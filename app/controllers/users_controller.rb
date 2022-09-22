class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    user
    @organised_events = user.events
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
