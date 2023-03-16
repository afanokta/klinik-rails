class MedicalHistory < ApplicationRecord
  belongs_to :appointment

  validates_uniqueness_of :appointment_id

  scope :join_appointment, -> { joins(:appointment => :schedule) }
  scope :patient_history, ->(current_user) { join_appointment.where(appointment: { patient_id: current_user.id }) }
  scope :doctor_history, ->(current_user) { join_appointment.where(schedule: { doctor_id: current_user.id }) }

  def new_attr
    {
      id: self.id,
      complaint: self.complaint,
      diagnosis: self.diagnosis,
      prescription: self.prescription,
      appointment: self.appointment,
      user: self.appointment.patient.new_attr,
      doctor: self.appointment.schedule.doctor.doc_attr
    }
  end
end
