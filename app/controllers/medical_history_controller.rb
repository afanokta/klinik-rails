class MedicalHistoryController < ApplicationController
end
class MedicalHistoryController < ApplicationController
  before_action :set_medical_history, only: [:show, :update, :destroy]

  def index
    @meds = MedicalHistory.patient_history(current_user) if current_user.patient?
    @meds = MedicalHistory.doctor_history(current_user) if current_user.doctor?
    render json: @meds.map { |med| med.new_attr }, status: :ok
  end

  def create
    @medical_history = MedicalHistory.new(medical_history_params)
    if !@medical_history.save
      return render json: @medical_history.errors, status: :unprocessable_entity
    end
    render json: @medical_history.new_attr, status: :ok
  end

  def show
    render json: @medical_history.new_attr
  end

  def update
    if !@medical_history.update(medical_history_params)
      return render json: @medical_history.errors, status: :unprocessable_entity
    end
    render json: @medical_history.new_attr, status: :ok
  end

  def destroy
    if !@medical_history.destroy
      return render json: @medical_history.errors, status: :unprocessable_entity
    end
    render json: @medical_history.new_attr, status: :ok
  end

  private

  def set_medical_history
    @medical_history = MedicalHistory.find_by_id(params[:id])
    if @medical_history.nil?
      return render json: { message: 'Medical History not found' }, status: :not_found
    end
  end

  def medical_history_params
    params.require(:medical_history).permit(:complaint, :diagnosis, :prescription, :appointment_id)
  end
end
