require 'rails_helper'
RSpec.describe Assignment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:task) }
  end
end
