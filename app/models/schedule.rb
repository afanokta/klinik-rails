class Schedule < ApplicationRecord
  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  has_many :appointments

  validates_uniqueness_of :doctor_id, scope: [:start_time, :end_time, :day]

  enum day: {
    Sunday: 0,
    Monday: 1,
    Tuesday: 2,
    Wednesday: 3,
    Thursday: 4,
    Friday: 5,
    Saturday: 6
  }

  def new_attr
    {
      id: self.id,
      doctor: self.doctor&.doc_attr,
      day: self.day,
      start_time: self.start_time,
      end_time: self.end_time
    }
  end
end
