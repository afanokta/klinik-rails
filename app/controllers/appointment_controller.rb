class AppointmentController < ApplicationController
  before_action :set_appointment, only: %I[show update destroy]
  before_action :doctor?, only: %I[update destroy]
  before_action :allowed?, only: %I[update destroy]

  def index
    @appointments = Appointment.by_doctor(current_user) if current_user.doctor?
    @appointments = Appointment.by_patient(current_user) if current_user.patient?
    render json: @appointments.map(&:new_attr), status: :ok
  end

  def create
    @appointment = Appointment.new(appointment_params)
    return render json: @appointment.errors, status: :unprocessable_entity unless @appointment.save

    render json: @appointment.new_attr, status: :ok
  end

  def show
    # @appointment = Appointment.where
    render json: @appointment.new_attr
  end

  def update
    return render json: @appointment.errors, status: :unprocessable_entity unless @appointment.update(appointment_params)

    render json: @appointment.new_attr, status: :ok
  end

  def destroy
    return render json: @appointment.errors, status: :unprocessable_entity unless @appointment.destroy

    render json: @appointment.new_attr, status: :ok
  end

  private

  def set_appointment
    @appointment = Appointment.find_by_id(params[:id])
    return render json: { message: 'Appointment not found' }, status: :not_found if @appointment.nil?
  end

  def appointment_params
    params.require(:appointment).permit(:schedule_id, :status, :date, :patient_id)
  end

  def allowed?
    if current_user.doctor! && Appointment.doctor_detail(@appointment, current_user).blank?
      render json: { message: 'you are not allowed!!' }, status: :forbidden
      return
    end
  end

  def doctor?
    return render json: { message: 'only doctor can access!!' }, status: :forbidden unless current_user.doctor?
  end
end
