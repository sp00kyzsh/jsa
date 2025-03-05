class TimeOffRequest < ApplicationRecord
  belongs_to :employee

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: { in: %w[pending approved denied] }

  before_validation :set_default_status

  private

  def set_default_status
    self.status ||= "pending"
  end
end
