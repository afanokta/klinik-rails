class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :update, :destroy]
  before_action :check_doctor?, only: [:create, :update, :destroy]
  before_action :allowed?, only: [:create, :update, :destroy]

  def index
    @schs = Schedule.all
    render json: @schs.map(&:new_attr), status: :ok
  end

  def create
    schedule_params.doctor_id = current_user.id
    @schedule = Schedule.new(schedule_params)
    return render json: @schedule.errors, status: :unprocessable_entity unless @schedule.save

    render json: @schedule.new_attr, status: :ok
  end

  def show
    render json: @schedule.new_attr
  end

  def update
    return render json: @schedule.errors, status: :unprocessable_entity unless @schedule.update(schedule_params)
    render json: @schedule.new_attr, status: :ok
  end

  def destroy
    return render json: @schedule.errors, status: :unprocessable_entity unless @schedule.destroy
    render json: @schedule.new_attr, status: :ok
  end

  private

  def set_schedule
    @schedule = Schedule.find_by_id(params[:id])
    return render json: { message: 'Medical History not found' }, status: :not_found if @schedule.nil?
  end

  def schedule_params
    params.require(:schedule).permit(:day, :start_time, :end_time, :doctor_id)
  end

  def check_doctor?
    return render json: { message: 'only doctor can make schedule!!' }, status: :forbidden unless current_user.doctor?
  end

  def allowed?
    if @schedule.doctor_id != current_user.id
      render json: { message: 'you\'re not allowed!!' }, status: :forbidden
      return
    end
  end
end
