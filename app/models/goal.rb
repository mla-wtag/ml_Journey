class Goal < ApplicationRecord
  belongs_to :user

  enum status: { todo: 0, progress: 1, done: 2 }

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 2500 }
  validates :date, presence: true
end
