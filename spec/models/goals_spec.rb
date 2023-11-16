require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:goal) { FactoryBot.create(:goal) }

  describe 'validations' do
    it 'checks if Goal can be created with all variables' do
      expect(goal).to be_valid
    end

    it 'validates presence of attributes' do
      is_expected.to validate_presence_of(:title).with_message(I18n.t('validations.presence'))
      is_expected.to validate_presence_of(:description).with_message(I18n.t('validations.presence'))
      is_expected.to validate_presence_of(:date).with_message(I18n.t('validations.presence'))
    end

    it 'validates the role enum' do
      is_expected.to define_enum_for(:status).with_values(todo: 0, progress: 1, done: 2)
    end

    it 'checks that a Goal without a title is not valid' do
      invalid_goal = FactoryBot.build(:goal, title: nil)
      expect(invalid_goal).not_to be_valid
    end
    it 'checks that a Goal without content is not valid' do
      invalid_goal = FactoryBot.build(:goal, description: nil)
      expect(invalid_goal).not_to be_valid
    end

    it 'checks that a Goal without a date is not valid' do
      invalid_goal = FactoryBot.build(:goal, date: nil)
      expect(invalid_goal).not_to be_valid
    end

    it 'checks that a task without status is not valid' do
      invalid_task = FactoryBot.build(:task, status: nil)
      expect(invalid_task).not_to be_valid
    end

    describe 'Goal association with user' do
      it 'belongs to a user' do
        is_expected.to belong_to(:user)
      end
    end
  end
end
