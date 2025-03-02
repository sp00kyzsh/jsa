class Employee < ApplicationRecord
  validates :first_name, :last_name, :hiring_date, :job_title, presence: true
  validates :employment_status, inclusion: { in: ["Part-Time", "Full-Time", "Temp"] }
  has_many :employee_time_logs, dependent: :destroy

  def total_hours_worked
    employee_time_logs.where.not(clock_out: nil).sum { |log| log.duration } / 60.0
  end
end
