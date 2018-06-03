class Task < ApplicationRecord
  validates :name, presence: true, length: { in: 1..140 }
end
