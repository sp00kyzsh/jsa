# Clear existing data to prevent duplicates
Jsa.destroy_all

# Define sample data
10.times do |i|
  Jsa.create!(
    job_description: [ "Weeding", "Excavation", "Pipe Installation", "Concrete Pouring", "Scaffolding" ].sample,
    date: Date.today - rand(1..30),
    location: [ "South Tank Fields", "North Plant", "East Refinery", "West Storage" ].sample,
    facilitator: Faker::Name.name,
    marathon_rep: Faker::Name.name,
    safety_rep: Faker::Name.name,
    work_crew_supervisor: Faker::Name.name,
    critical_steps: Faker::Lorem.sentence(word_count: 8),
    potential_hazards: Faker::Lorem.sentence(word_count: 10),
    safety_measures: Faker::Lorem.sentence(word_count: 10),
    procedures_reviewed: Faker::Lorem.sentence(word_count: 10),
    worst_case: Faker::Lorem.sentence(word_count: 10),
    special_tools: Faker::Lorem.words(number: 3).join(", "),

    potential_hazard_key: [ "Abrasion/cut/penetration", "Electrical/Shock/Explosive", "Slip-Trip-Fall" ].sample(3),
    required_ppe: [ "Hard Hat", "Safety Glasses", "Ear Protection" ].sample(3),
    required_protection_key: [ "Fire Watch w/ Extinguisher", "Safe Work Procedure", "Tool Lanyards" ].sample(3),
    body_part_key: [ "Hands", "Eyes", "Legs", "Back" ].sample(3),
    training_required: [ "Confined Space", "Fire Watch", "Hand/Power Tool" ].sample(2),
    mobile_equipment: [ "Boom Lift", "Skid Steer", "Lawn Mower" ].sample(2),
    other_inspections: [ "Lift Plan?", "Tool/Equip. Inspection?", "Emergency Evac. Plan" ].sample(2),

    employee_name: Faker::Name.name,
    initials: Faker::Alphanumeric.alpha(number: 2).upcase,
    submission_date: Date.today - rand(1..30),
    submission_time: Time.now - rand(1..30000),

    foreman_signature: Faker::Name.name,
    operations_signature: Faker::Name.name,
    safety_rep_signature: Faker::Name.name,
    audit_date: Date.today - rand(1..30),
    signature_date: Date.today - rand(1..30)
  )
end

puts "✅ Seeded 10 JSA records successfully!"

require 'faker'

# 🔴 Fix: Delete dependent records first
EmployeeTimeLog.destroy_all # Delete all time logs first
Employee.destroy_all # Then delete employees

puts "Seeding employees and clock-in/out data..."

# Create Employees
10.times do
  employee = Employee.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    hiring_date: Faker::Date.between(from: 3.years.ago, to: Date.today),
    job_title: Faker::Job.title,
    active: [true, false].sample,
    employment_status: ["Part-Time", "Full-Time", "Temp"].sample
  )

  # Create random clock-in/clock-out logs for each employee
  rand(5..10).times do
    clock_in_time = Faker::Time.between(from: 5.days.ago, to: Time.current)

    # Ensure clock_out is always AFTER clock_in
    clock_out_time = Faker::Time.between(from: clock_in_time + 1.hour, to: clock_in_time + 8.hours)

    employee.employee_time_logs.create!(
      clock_in: clock_in_time,
      clock_out: clock_out_time
    )
  end
end

puts "✅ Seeding complete!"

