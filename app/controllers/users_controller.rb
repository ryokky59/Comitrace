class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
  end

end
