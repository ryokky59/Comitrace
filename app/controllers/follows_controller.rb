class FollowsController < ApplicationController
  respond_to? :js

  def create
     @user = User.find(params[:follow][:followed_id])
     current_user.follow(@user)
     @user #js.erbに渡す
  end

  def destroy
    @user = Follow.find(params[:id]).followed
    current_user.unfollow(@user)
    @user
  end

end
