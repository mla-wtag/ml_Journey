require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'checks if User can be created with all variables' do
    expect(user).to be_valid
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

  it 'validates the content type of profile_photo' do
    valid_content_types = %w[image/jpg image/jpeg image/png]

    valid_content_types.each do |content_type|
      user = build(:user, profile_photo: fixture_file_upload('spec/fixtures/test.jpeg', content_type))
      expect(user).to be_valid, "Expected user to be valid with content_type: #{content_type}, but got errors: #{user.errors.full_messages}"
    end
  end

  describe '#generate_confirmation_token' do
    let(:user) { FactoryBot.create(:user, confirmation_token: nil) }

    it 'generates a confirmation token' do
      user.generate_confirmation_token
      expect(user.confirmation_token).not_to be_nil
    end

    it 'generates a unique confirmation token each time it is called' do
      original_token = user.generate_confirmation_token
      new_token = user.generate_confirmation_token
      expect(original_token).not_to eq(new_token)
    end
  end

  describe '#confirmed?' do
    let(:unconfirmed_user) { FactoryBot.create(:user, confirmed_at: nil) }
    let(:confirmed_user) { FactoryBot.create(:user, confirmed_at: Time.current) }

    it 'returns false for unconfirmed user' do
      expect(unconfirmed_user.confirmed?).to be_falsey
    end

    it 'returns true for confirmed user' do
      expect(confirmed_user.confirmed?).to be_truthy
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:assignments) }
    it { is_expected.to have_many(:tasks).through(:assignments) }
    it { is_expected.to have_many(:journals).dependent(:destroy).inverse_of(:user) }
  end
end
