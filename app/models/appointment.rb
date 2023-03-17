class Appointment < ApplicationRecord
  belongs_to :schedule
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  has_one :medical_history

  validates_uniqueness_of :schedule_id, scope: [:patient_id, :date]

  scope :join_schedule, -> { joins(:schedule) }
  scope :by_doctor, ->(doctor_id) { join_schedule.where(schedule: { doctor_id: doctor_id }) }
  scope :doctor_detail, ->(app, doctor_id) { by_doctor(doctor_id).where(id: app.id) }

  scope :by_patient, ->(patient_id) { where(patient_id: patient_id) }
  scope :patient_detail, ->(current_user) { where(patient_id: current_user.id) }

  enum status: {
    process: 0,
    done: 1,
    cancel: 2
  }

  def new_attr
    {
      id: self.id,
      schedule: self.schedule,
      date: self.date,
      status: self.status,
      patient: self.patient.new_attr
    }
  end

  def self.display_all(params)
    start_date = params[:start_date]
    end_date = params[:end_date]
    doc_id = params[:doctor_id].to_i if params[:doctor_id].present?
    patient_id = params[:patient_id].to_i if params[:patient_id].present?
    start_date = start_date.present? ? start_date : '2000-01-01'
    end_date = end_date.present? ? end_date : '2099-01-01'
    # joins(:schedule).where(schedule: { doctor_id: doctor_id }) if doctor_id.present?

    if patient_id.present?
      return where('date BETWEEN ? AND ?', start_date, end_date).where(patient_id: patient_id)
    end

    if doc_id.present?
      return where('date BETWEEN ? AND ?', start_date, end_date).by_doctor(doc_id)
    end

    where('date BETWEEN ? AND ?', start_date, end_date)
  end
end
