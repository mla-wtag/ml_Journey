require 'rails_helper'
RSpec.describe Journal, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:valid_journal) { FactoryBot.create(:journal) }

  it 'checks if Journal can be created with all variables' do
    except(user1).to be_valid
  end

  it 'validates presence of attributes' do
    should validate_presence_of(:title)
    should validate_presence_of(:date)
    should validate_presence_of(:content)
    should validate_presence_of(:goals_today)
    should validate_presence_of(:goals_tomorrow)
  end

  it 'checks that a journal with specific attributes is not valid' do
    invalid_journal = FactoryBot.create(
      :journal,
      title: 'Name',
      date: '2023-12-12',
      content: 'A lot of content',
      goals_today: 'A lot of goals',
      goals_tomorrow: '',
    )
    expect(invalid_journal).not_to be_valid
  end
end
