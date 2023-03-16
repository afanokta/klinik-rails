class SchedulesController < ApplicationController
    before_action :set_schedule, only: [:show, :update, :destroy]

    # GET /schedules
    def index
      @schedules = Schedule.all
  
      render json: @schedules.map { |schedules| schedule.new_attributes }
    end
  
    # GET /schedule/1
    def show
      render json: @schedule.new_attributes
    end
  
    # POST /schedule
    def create
      @schedule = Schedule.new(schedule_params)
  
      if @schedule.save
        render json: @schedule.new_attributes, status: :created
      else
        render json: @schedule.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /schedule/1
    def update
      if @schedule.update(schedule_params)
        render json: @schedule.new_attributes
      else
        render json: @schedule.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /schedule/1
    def destroy
      @schedule.destroy
    end
  
    private
  
      # Only allow a trusted parameter "white list" through.
      def schedule_params
        params.require(:schedule).permit(:id, :day, :start_time, :end_time )
    end
    def set_schedule
      @schedule = Schedule.find_by_id(params[:id])
      if @schedule.nil?
        render json: { error: "schedule not found" }, status: :not_found
      end
    end
#     def schedule_params
#     {
#       id: params[ :id],
#     #   doctor_id: params[ :doctor_id],
#       day: params[ :day],
#       start_time: params[ :start_time],
#       end_time: params[ :end_time]
#     }
#   end

end
