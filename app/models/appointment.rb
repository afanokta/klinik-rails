class Appointment < ApplicationRecord
  belongs_to :schedule
  belongs_to :patient, class_name: "User", foreign_key: "patient_id"
  has_one :medical_history

  validates_uniqueness_of :schedule_id, scope: [:patient_id, :date]

  scope :join_schedule, -> { joins(:schedule) }
  scope :by_doctor, ->(current_user) { join_schedule.where(schedule: { doctor_id: current_user.id }) }
  scope :doctor_detail, ->(app, current_user) { by_doctor(current_user).where(id: app.id) }

  scope :by_patient, ->(current_user) { where(patient_id: current_user.id) }
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

  def self.filter
  end
end
