# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'
Feedback.destroy_all
User.destroy_all
Slot.destroy_all

now = Time.now
tomorrow = now + 1.day
yesterday = now - 1.day
mentor = User.create(first_name: 'Seed', last_name: 'Mentor', phase: 1, mentor: true, email: 'mentor@seed.com', password: 'password', password_confirmation: 'password')

student = User.create(first_name: 'Seed', last_name: 'Student', phase: 1, mentor: true, email: 'student@seed.com', password: 'password', password_confirmation: 'password')

# create slot with now ~ tomorrow
5.times do |i|
  s = Slot.create(title: "SeedSlot_Active#{i}", capacity: i, start_time: now, end_time: tomorrow, mentor: mentor )

  Appointment.create(student: student, slot: s)
end

# create slot with 2days ago ~ yesterday

5.times do |i|
  s = Slot.create(title: "SeedSlot_Old#{i}", capacity: i, start_time: yesterday - 1.day, end_time: yesterday, mentor: mentor )
  Appointment.create(student: student, slot: s)
end



# Feedback.create(rating: 1, comment: 'AAA', appointment_id: 1, user_id: 1)
# Feedback.create(rating: 5, comment: 'BBB', appointment_id: 2, user_id: 2	)
