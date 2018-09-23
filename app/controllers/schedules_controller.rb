class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:edit, :update, :delete, :show]

  def top
  end

  def index
    @schedules = Schedule.order(created_at: :desc).page(params[:page]).per(6)
    #@schedules = Schedule.all.includes(:schedule_plans)子要素も載せたい時
  end

  def new
    if params[:back]
      @schedule = Schedule.new(schedule_params)
    else
      @schedule = Schedule.new
      @schedule.schedule_plans.build
    end
  end

  def confirm
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id

    gon.data = []
    gon.labels = []
    gon.bgcolor = []
    color = ["#FF0000", "#FE9A2E", "#F7FE2E", "#0040FF", "#00FF40", "#DF01D7", "#00FFFF", "#8000FF", "#BFFF00", "#045FB4"]

    @schedule.schedule_plans.each do |schedule_plan|
      if schedule_plan.start_time.present? || schedule_plan.end_time.present?
      if schedule_plan.start_time > schedule_plan.end_time
        gon.data << 24 * 60 * 60 - (schedule_plan.start_time.to_i - schedule_plan.end_time.to_i)
      else
        gon.data << (schedule_plan.end_time.to_i - schedule_plan.start_time.to_i)
      end
      gon.labels << schedule_plan.plan
      gon.bgcolor << color.sample
    end
    end

    render 'new' if @schedule.invalid?
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id
    if @schedule.save
      redirect_to schedule_path(id: @schedule.id)
    else
      render 'new'
    end
  end

  def edit
    @schedule.user_id = current_user.id
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to schedule_path(id: @schedule.id)
    else
      render 'edit'
    end
  end

  def delete
  end

  def show
    @user = User.find_by(id: @schedule.user_id)

    gon.data = []
    gon.labels = []
    gon.bgcolor = []
    color = ["#FF0000", "#FE9A2E", "#F7FE2E", "#0040FF", "#00FF40", "#DF01D7", "#00FFFF", "#8000FF", "#BFFF00", "#045FB4"]


    @schedule.schedule_plans.each do |schedule_plan|
      if schedule_plan.start_time > schedule_plan.end_time
        gon.data << 24 * 60 * 60 - (schedule_plan.start_time.to_i - schedule_plan.end_time.to_i)
      else
        gon.data << (schedule_plan.end_time.to_i - schedule_plan.start_time.to_i)
      end
      gon.labels << schedule_plan.plan
      gon.bgcolor << color.sample
    end

    @favorite = current_user.favorites.find_by(schedule_id: @schedule.id)

    @comments = @schedule.comments
    @comment = @schedule.comments.build
  end

  private
  def schedule_params
    params.require(:schedule).permit(:title, :content, schedule_plans_attributes: [:id, :schedule_id, :plan, :start_time, :end_time, :_destroy])
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end



end
