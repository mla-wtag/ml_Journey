require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user1) { FactoryBot.create(:user) }

  it 'checks if User can be created with all variables' do
    expect(user1).to be_valid
  end

  it 'validates presence of attributes' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:employee_id)
    should validate_presence_of(:date_of_birth)
    should validate_presence_of(:joining_day)
    should validate_presence_of(:designation)
    should validate_presence_of(:password)
    should validate_presence_of(:email)
    should validate_presence_of(:profile_photo)
    should validate_presence_of(:role)
  end

  it 'validates the role enum' do
    should define_enum_for(:role).with_values(user_role: 0, admin_role: 1)
  end

  it 'validates format of email' do
    should allow_value('user@example.com').for(:email)
    should_not allow_value('invalid-email').for(:email)
    should_not allow_value('user@').for(:email)
    should_not allow_value('@example.com').for(:email)
  end

  it 'checks that a User with specific attributes is not valid' do
    user2 = FactoryBot.build(
      :user,
      first_name: 'Michael',
      last_name: 'Lavelanet',
      employee_id: '1234',
      date_of_birth: '2004-12-12',
      joining_day: '2004-12-12',
      designation: 'Junior Software Engineer',
      email: 'michael.lavelanet@mail.com',
      password: '',
    )
    expect(user2).not_to be_valid
  end

  describe 'profile_photo validations' do
    it 'validates content type of profile_photo' do
      user = build(:user, profile_photo: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test.txt'), 'text/plain'))
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("#{I18n.t('attributes.profile_photo')} #{I18n.t('validations.content_type')}")
    end
  end

  it 'validates size of profile_photo' do
    user = build(:user, profile_photo: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'large_image.png'), 'image/png'))
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include("#{I18n.t('attributes.profile_photo')} #{I18n.t('validations.photo')}")
  end
end
