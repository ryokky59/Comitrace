class CreateStocksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @schedules = @user.schedules.page(params[:page]).per(6)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
