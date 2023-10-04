class Journal < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :date, presence: true
  validates :content, presence: true
  validates :goals_tomorrow, presence: true
  validates :goals_today, presence: true

  validates_length_of :title, maximum: 255, message: :too_long_journal
  validates_length_of :content, maximum: 5000, message: :too_long_journal
  validates_length_of :goals_today, maximum: 500, message: :too_long_journal
  validates_length_of :goals_tomorrow, maximum: 500, message: :too_long_journal
end
