class User < ApplicationRecord
  has_secure_password
  validates_presence_of :firstname, :lastname, :employee_id, :date_of_birth, :joining_day, :designation, :password, message: ->(_, _) { I18n.t('validations.presence') }
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: ->(_, _) { I18n.t('validations.valid') } }
end
