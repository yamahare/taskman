class Task < ApplicationRecord

  enum priority: { high: 3, middle: 2, low: 1, undef: 0 }

  validates :name,     presence: true, length: { in: 1..140 }
  validates :priority, presence: true, inclusion: { in: %w(high middle low undef) }
  validate :end_date_cannot_be_in_the_past

  def end_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, :can_not_use_past_day)
    end
  end
end
