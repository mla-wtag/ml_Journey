require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for an admin user' do
    let(:user) { FactoryBot.create(:user, role: 'admin_role') }

    it 'can manage User' do
      should be_able_to(:manage, :all)
    end
  end

  describe 'for an regular user' do
    let(:user) { FactoryBot.create(:user, role: 'user_role') }

    %i(create read update destroy confirm_email).each do |action|
      it "can #{action} User" do
        is_expected.to be_able_to(action, User)
      end

      it "can #{action} Journal" do
        is_expected.to be_able_to(action, Journal)
      end
    end

    it 'cannot access the index action' do
      is_expected.to_not be_able_to(:index, User)
    end
  end

  describe 'for a guest' do
    let(:user) { nil }

    it 'can manage create, new and confirm_email' do
      is_expected.to be_able_to(:create, User)
      is_expected.to be_able_to(:new, User)
      is_expected.to be_able_to(:confirm_email, User)
    end

    it 'cannot manage Journal' do
      should_not be_able_to(:manage, Journal)
    end
  end
end
