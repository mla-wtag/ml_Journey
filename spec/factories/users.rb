FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    employee_id { FFaker::Random.rand(1000..9999).to_s }
    date_of_birth { FFaker::Time.between(30.years.ago, 18.years.ago).to_date }
    joining_day { FFaker::Time.between(10.years.ago, Date.today).to_date }
    designation { FFaker::Job.title }
    email { FFaker::Internet.email }
    profile_photo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test.jpeg'), 'image/jpeg') }
    role { %w[user_role admin_role].sample }
    password { 'code' }
    confirmation_token { SecureRandom.urlsafe_base64 }
    confirmed_at { nil }
  end
end
