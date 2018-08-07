class User < ApplicationRecord
  before_validation { username.downcase! }
  before_validation { email.downcase! }
  after_update :check_least_one_admin
  before_destroy :check_least_one_admin_before_destroy

  validates :display_name, length: { maximum: 100 }
  validates :email,        presence: true, uniqueness: true
  validates :username,     presence: true, length: { in: 3..15 }, uniqueness: true,
                           format: {with: /\A[a-zA-Z0-9_]+\Z/},
                           ban_reserved: true
  has_secure_password

  has_many :tasks, dependent: :destroy

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 管理者ユーザが１名以上必要
  def check_least_one_admin
    if User.where(is_admin: true).size == 0
      errors.add(:is_admin, :at_least_one_required)
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  # 管理者ユーザが１名以上必要
  def check_least_one_admin_before_destroy
    if User.where(is_admin: true).size == 1 && self.is_admin?
      errors.add(:is_admin, :at_least_one_required)
      throw(:abort)
    end
  end

end
