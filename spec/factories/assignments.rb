FactoryBot.define do
  factory :assignment do
    association :user
    association :task
  end
end
