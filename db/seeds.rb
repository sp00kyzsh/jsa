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

Employee.all.each do |employee|
  # Ensure existing logs are cleared before reseeding (optional)
  employee.employee_time_logs.destroy_all

  # Generate a mix of completed and ongoing shifts
  5.times do
    clock_in_time = Faker::Time.backward(days: rand(1..5), period: :morning)
    clock_out_time = clock_in_time + rand(4..8).hours # Ensure realistic shift lengths

    employee.employee_time_logs.create!(
      clock_in: clock_in_time,
      clock_out: [clock_out_time, nil].sample # Some logs will have clock_out, some won't
    )
  end

  # Ensure at most ONE ongoing shift exists per employee
  if employee.employee_time_logs.where(clock_out: nil).count > 1
    oldest_unfinished = employee.employee_time_logs.where(clock_out: nil).order(:clock_in).first
    oldest_unfinished.update!(clock_out: oldest_unfinished.clock_in + 8.hours)
  end
end

puts "✅ Employees and time logs seeded successfully!"


