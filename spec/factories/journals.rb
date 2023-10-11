FactoryBot.define do
  factory :journal do
    title { FFaker::Book.title }
    date { FFaker::Time.between(1.years.ago, Date.today).to_date }
    content { FFaker::Lorem.paragraph }
    goals_today { FFaker::Lorem.sentence }
    goals_tomorrow { FFaker::Lorem.sentence }
    user
  end
end
