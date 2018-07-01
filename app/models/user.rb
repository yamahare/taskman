class User < ApplicationRecord
  
  validates :name,     presence: true, length: { in: 1..100 }
  validates :email,    presence: true
  has_secure_password

  has_many :tasks, dependent: :destroy

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
