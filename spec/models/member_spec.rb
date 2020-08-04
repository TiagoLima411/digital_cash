require 'rails_helper'
#require 'rspec/rails'

RSpec.describe Member, type: :model do

  context 'Validates' do
    it 'Member must be valid' do
      member = create(:member)
      expect(member.user).to be_kind_of(User)
    end
  end

  context 'Associations' do
    it { is_expected.to belong_to(:city) }
    it { is_expected.to belong_to(:state) }
  end

end
