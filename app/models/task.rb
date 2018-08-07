class Task < ApplicationRecord

  enum priority: { high: 3, middle: 2, low: 1, undef: 0 }
  enum status: { completed: 2, working: 1, waiting: 0 }

  validates :name,     presence: true, length: { in: 1..140 }
  validates :priority, presence: true, inclusion: { in: %w(high middle low undef) }
  validates :status,   presence: true, inclusion: { in: %w(completed working waiting) }
  validate :end_date_cannot_be_in_the_past

  belongs_to :user

  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels
  accepts_nested_attributes_for :task_labels, allow_destroy: true

  scope :like_username, ->(name) do
    if name.present?
      where("name LIKE ?", "%#{name}%")
    end
  end

  scope :search_with_status, ->(status) do
    if status
      where(status: status)
    end
  end

  def end_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, :can_not_use_past_day)
    end
  end
end
