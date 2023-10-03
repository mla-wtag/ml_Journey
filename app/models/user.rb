class User < ApplicationRecord
  has_many :journals
  has_secure_password
  enum role: { user_role: 0, admin_role: 1 }
  has_one_attached :profile_photo
  validates_presence_of :first_name, :last_name, :employee_id, :date_of_birth, :joining_day, :designation, :role, message: ->(_, _) { I18n.t('validations.presence') }
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: ->(_, _) { I18n.t('validations.valid') } }
  validates :profile_photo, presence: true,
                            content_type: { in: %w[image/jpeg image/png image/jpg], message: I18n.t('validations.content_type') },
                            size: { less_than: 5.megabytes, message: I18n.t('validations.photo') }

  def image_resize
    profile_photo.variant(resize_to_limit: [200, 200]).processed
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64(24)
  end

  def confirmed?
    confirmed_at.present?
  end
end
