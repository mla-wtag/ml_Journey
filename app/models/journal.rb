class Journal < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :date, presence: true
  validates :content, presence: true, length: { maximum: 5000 }
  validates :goals_tomorrow, presence: true, length: { maximum: 500 }
  validates :goals_today, presence: true, length: { maximum: 500 }
end
