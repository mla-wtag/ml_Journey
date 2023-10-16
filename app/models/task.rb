class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments

  enum status: { todo: 0, progress: 1, done: 2 }
end
