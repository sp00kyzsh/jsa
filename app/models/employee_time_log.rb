class EmployeeTimeLog < ApplicationRecord
  belongs_to :employee

  # Ensure valid clock-in and clock-out times
  validates :clock_in, presence: true
  validate :clock_out_after_clock_in

  def clock_out_after_clock_in
    if clock_out.present? && clock_out < clock_in
      errors.add(:clock_out, "must be after clock-in time")
    end
  end

  # Calculate shift duration
  def duration
    return nil unless clock_in && clock_out
    ((clock_out - clock_in) / 60).round(2) # Convert to minutes
  end
end
