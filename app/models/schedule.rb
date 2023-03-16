class Schedule < ApplicationRecord
   # has_many :appointment, dependent: :destroy
   # belongs_to :user
   def new_attributes
      {
         #  doctor_id: self.doctor_id,
          day: self.day,
          start_time: self.start_time,
          end_time: self.end_time
      }
  end

end
