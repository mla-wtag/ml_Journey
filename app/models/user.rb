class User < ApplicationRecord
  has_secure_password
  enum role: { user: 0, admin: 1 }
  has_one_attached :profile_photo
  validates_presence_of :first_name, :last_name, :employee_id, :date_of_birth, :joining_day, :profile_photo, :designation, :role, message: ->(_, _) { I18n.t('validations.presence') }
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: ->(_, _) { I18n.t('validations.valid') } }

  def image_resize
    profile_photo.variant(resize_to_limit: [200, 200]).processed
  end
end
