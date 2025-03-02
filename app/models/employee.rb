class Employee < ApplicationRecord
  validates :first_name, :last_name, :hiring_date, :job_title, presence: true
  validates :employment_status, inclusion: { in: ["Part-Time", "Full-Time", "Temp"] }
end
