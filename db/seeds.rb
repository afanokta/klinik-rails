# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# ===== DEPARTMENT DATA =====
Departement.create([
  {
    "name": "Poli Umum"
  },
  {
    "name": "Poli Kandungan"
  },
  {
    "name": "Poli Gigi"
  }
])

# ===== PATIENT USER =====
10.times do
  User.create(
    "username": Faker::Internet.username(specifier: 5..10),
    "name": Faker::Name.first_name,
    "email": Faker::Internet.email,
    "password": 'password',
    "gender": Faker::Number.between(from: 0, to: 1),
    "phone_number": Faker::PhoneNumber.cell_phone_in_e164,
    "role": 0,
    "dob": Faker::Date.birthday(min_age: 18, max_age: 65),
    "departement_id": nil
  )
end

# ===== DOCTOR USER =====
5.times do
  User.create(
    "username": Faker::Internet.username(specifier: 5..10),
    "name": Faker::Name.first_name,
    "email": Faker::Internet.email,
    "password": 'password',
    "gender": Faker::Number.between(from: 0, to: 1),
    "phone_number": Faker::PhoneNumber.cell_phone_in_e164,
    "role": 1,
    "dob": Faker::Date.birthday(min_age: 18, max_age: 65),
    "departement_id": Departement.all.sample.id
  )
end

# ===== ADMIN USER =====
3.times do
  User.create(
    "username": Faker::Internet.username(specifier: 5..10),
    "name": Faker::Name.first_name,
    "email": Faker::Internet.email,
    "password": 'password',
    "gender": Faker::Number.between(from: 0, to: 1),
    "phone_number": Faker::PhoneNumber.cell_phone_in_e164,
    "role": 2,
    "dob": Faker::Date.birthday(min_age: 18, max_age: 65),
    "departement_id": nil
  )
end

# ===== SCHEDULE =====
5.times do
  Schedule.create(
    "day": Faker::Number.between(from: 0, to: 6),
    "start_time": "10:00",
    "end_time": "12:00",
    "doctor_id": User.where(role: 1).sample.id
  )
end

# ===== APPOINTMENT =====
10.times do
  Appointment.create(
    "date": Faker::Date.between(from: 2.days.from_now, to: 7.days.from_now),
    "status": 0,
    "patient_id": User.where(role: 0).sample.id,
    "schedule_id": Schedule.all.sample.id
  )
end



puts "Berhasil Menjalankan Seed"
