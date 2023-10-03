class Journal < ApplicationRecord
  belongs_to :user
  validates_presence_of(:title, :date, :content, :goals_tomorrow, :goals_today, message: ->(_, _) { I18n.t('validations.presence') })
end
