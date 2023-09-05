class User < ApplicationRecord
  has_secure_password
  validates :firstname, presence: true, uniqueness: true
  validates :lastname, presence: true
  validates :employee_id, presence: true
  validates :date_of_birth, presence: true
  validates :joining_day, presence: true
  validates :designation, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
