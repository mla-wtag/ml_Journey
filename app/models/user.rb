class User < ApplicationRecord
  has_secure_password
  validates_presence_of :firstname, :lastname, :employee_id, :date_of_birth, :joining_day, :designation, :password
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must be a valid email address' }
end
