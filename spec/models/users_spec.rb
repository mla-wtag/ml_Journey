require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user1) do
    FactoryBot.create(:user)
  end

  it 'checks if User can be created with all variables' do
    expect(user1.valid?).to be_truthy
  end

  let(:user2) do
    FactoryBot.create(
      :user,
      firstname: 'Michael',
      lastname: 'Lavelanet',
      employee_id: '1234',
      date_of_birth: '2004-12-12',
      joining_day: '2004-12-12',
      designation: 'Junior Software Engineer',
      email: 'Mail',
      password: '',
    )
  end
  it 'checks that a User with specific attributes is not valid' do
    expect { user2.save? }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
