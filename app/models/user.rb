class User < ApplicationRecord
  
  validates :name,     presence: true, length: { in: 1..100 }
  validates :email,    presence: true
  has_secure_password

  has_many :tasks, dependent: :destroy

end
