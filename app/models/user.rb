class User < ApplicationRecord
  has_secure_password
  validates :firstname, presence: true, uniqueness: true
end
