require 'rails_helper'
RSpec.describe Journal, type: :model do
  let(:journal) { FactoryBot.create(:journal) }

  describe 'variables' do
    it 'checks if Journal can be created with all variables' do
      expect(journal).to be_valid
    end
  end

  describe 'validations' do
    it 'validates presence of attributes' do
      should validate_presence_of(:title).with_message(I18n.t('validations.presence'))
      should validate_presence_of(:date).with_message(I18n.t('validations.presence'))
      should validate_presence_of(:content).with_message(I18n.t('validations.presence'))
      should validate_presence_of(:goals_today).with_message(I18n.t('validations.presence'))
      should validate_presence_of(:goals_tomorrow).with_message(I18n.t('validations.presence'))
    end
    it 'checks that a Journal without a title is not valid' do
      invalid_journal = FactoryBot.build(:journal, title: nil)
      expect(invalid_journal).not_to be_valid
    end

    it 'checks that a Journal without a date is not valid' do
      invalid_journal = FactoryBot.build(:journal, date: nil)
      expect(invalid_journal).not_to be_valid
    end

    it 'checks that a Journal without content is not valid' do
      invalid_journal = FactoryBot.build(:journal, content: nil)
      expect(invalid_journal).not_to be_valid
    end

    it 'checks that a Journal without goals for today is not valid' do
      invalid_journal = FactoryBot.build(:journal, goals_today: nil)
      expect(invalid_journal).not_to be_valid
    end

    it 'checks that a Journal without goals for tomorrow is not valid' do
      invalid_journal = FactoryBot.build(:journal, goals_tomorrow: nil)
      expect(invalid_journal).not_to be_valid
    end
  end

  describe 'Journal association with user' do
    it 'belongs to a user' do
      should belong_to(:user)
    end
  end
end
