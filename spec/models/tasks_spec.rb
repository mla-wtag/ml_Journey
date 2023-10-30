require 'rails_helper'
RSpec.describe Task, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let(:task) { FactoryBot.create(:task, creator: user) }

  describe 'validations' do
    it 'checks if task can be created with all variables' do
      expect(task).to be_valid
    end

    it 'validates presence of attributes' do
      is_expected.to validate_presence_of(:title).with_message(I18n.t('validations.presence'))
      is_expected.to validate_presence_of(:date).with_message(I18n.t('validations.presence'))
      is_expected.to validate_presence_of(:description).with_message(I18n.t('validations.presence'))
    end

    it 'validates the role enum' do
      is_expected.to define_enum_for(:status).with_values(todo: 0, progress: 1, done: 2)
    end

    it 'checks that a task without a title is not valid' do
      invalid_task = FactoryBot.build(:task, title: nil)
      expect(invalid_task).not_to be_valid
    end

    it 'checks that a task without a date is not valid' do
      invalid_task = FactoryBot.build(:task, date: nil)
      expect(invalid_task).not_to be_valid
    end

    it 'checks that a task without description is not valid' do
      invalid_task = FactoryBot.build(:task, description: nil)
      expect(invalid_task).not_to be_valid
    end

    it 'checks that a task without status is not valid' do
      invalid_task = FactoryBot.build(:task, status: nil)
      expect(invalid_task).not_to be_valid
    end

    it 'checks that a task without assignee is not valid' do
      invalid_task = FactoryBot.build(:task, users: [])
      expect(invalid_task).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a creator (user)' do
      is_expected.to belong_to(:creator).class_name('User')
    end

    it 'has many assignments' do
      is_expected.to have_many(:assignments).dependent(:destroy)
    end
  end

  describe 'Task association with assignment' do
    it 'has many assignments' do
      is_expected.to have_many(:assignments)
      is_expected.to have_many(:users).join_table(:assignments)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:creator).class_name('User').with_foreign_key('creator_id') }
    it { is_expected.to have_many(:assignments).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:assignments) }
  end
end
