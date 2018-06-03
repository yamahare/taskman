class Task < ApplicationRecord
  validates :name, presence: true, length: { in: 1..140 }
  validate :end_date_cannot_be_in_the_past

  def end_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, :can_not_use_past_day)
    end
  end
end
