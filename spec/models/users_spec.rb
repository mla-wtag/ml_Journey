require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user1) { FactoryBot.create(:user) }

  it 'checks if User can be created with all variables' do
    expect(user1).to be_valid
  end

  it 'validates presence of attributes' do
    should validate_presence_of(:firstname)
    should validate_presence_of(:lastname)
    should validate_presence_of(:employee_id)
    should validate_presence_of(:date_of_birth)
    should validate_presence_of(:joining_day)
    should validate_presence_of(:designation)
    should validate_presence_of(:password)
  end

  it 'checks that a User with specific attributes is not valid' do
    user2 = FactoryBot.build(
      :user,
      firstname: 'Michael',
      lastname: 'Lavelanet',
      employee_id: '1234',
      date_of_birth: '2004-12-12',
      joining_day: '2004-12-12',
      designation: 'Junior Software Engineer',
      email: 'michael.lavelanet@mail.com',
      password: '',
    )
    expect(user2).not_to be_valid
  end
end
