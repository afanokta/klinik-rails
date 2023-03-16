class User < ApplicationRecord
  has_secure_password

  belongs_to :departement, optional: true
  has_many :schedules, class_name: 'Schedule', foreign_key: 'doctor_id'
  has_many :appointments, class_name: 'Appointment', foreign_key: 'patient_id'

  scope :doctor, -> { where(role: 'doctor') }

  enum role: {
    patient: 0,
    doctor: 1,
    admin: 2
  }

  enum gender: {
    male: 0,
    female: 1
  }

  def new_attr
    {
      id: self.id,
      username: self.username,
      email: self.email,
      name: self.name,
      dob: self.dob,
      gender: self.gender,
      phone_number: self.phone_number,
      department: self.departement&.new_attr,
      role: self.role
    }
  end

  def doc_attr
    {
      email: self.email,
      dob: self.dob,
      gender: self.gender,
      phone_number: self.phone_number,
      department: self.departement.name,
      role: self.role
    }
  end
end
