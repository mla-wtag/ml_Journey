class User < ApplicationRecord
  enum role: { user: 0, amdin: 1 }
  has_secure_password
  has_one_attached :profile_photo
  validates_presence_of :firstname, :lastname, :employee_id, :date_of_birth, :joining_day, :profile_photo, :designation, message: ->(_, _) { I18n.t('validations.presence') }
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: ->(_, _) { I18n.t('validations.valid') } }

  def image_resize
    profile_photo.variant(resize_to_limit: [200, 200]).processed
  end

  def admin?
    role == 'admin'
  end
end
