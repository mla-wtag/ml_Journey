FactoryBot.define do
  factory :user do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    employee_id { FFaker::Random.rand(1000..9999).to_s }
    date_of_birth { FFaker::Time.between(30.years.ago, 18.years.ago).to_date }
    joining_day { FFaker::Time.between(10.years.ago, Date.today).to_date }
    designation { FFaker::Job.title }
    email { FFaker::Internet.email }
    password { 'code' }
  end
end
