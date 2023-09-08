FactoryBot.define do
  factory :user do
    firstname { "Michael" }
    lastname { "Lavelanet" }
    employee_id { "12345" }
    date_of_birth { "2004-12-12".to_date }
    joining_day { "2004-12-12".to_date }
    designation { "Junior Software Engineer" }
    email { "Mail" }
    password { "code" }
  end
end
