FactoryBot.define do
  factory :goal do
    title { FFaker::Book.title }
    description { FFaker::Lorem.sentence }
    date { FFaker::Time.between(1.years.ago, Date.today).to_date }
    status { Goal.statuses.keys.sample }
    user
  end
end
