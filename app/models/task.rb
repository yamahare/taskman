class Task < ApplicationRecord
  validate :name, presense: true
end
