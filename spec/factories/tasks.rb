FactoryBot.define do
  factory :task do
    title { FFaker::Book.title }
    description { FFaker::Lorem.paragraph }
    date { FFaker::Time.between(1.year.ago, Date.today).to_date }
    status { %w[todo progress done].sample }
    association :creator, factory: :user

    after(:build) do |task|
      task.user_ids = [task.creator.id]
    end
  end
end
