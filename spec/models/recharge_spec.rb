require 'rails_helper'

RSpec.describe Recharge, type: :model do

  before(:context) do
    @recharge = attributes_for(:recharge)
    @user = create(:user)
    @recharge[:user_id] = @user.id
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:pagseguro_payment_method) }
    it { is_expected.to validate_presence_of(:pagseguro_status) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:user)}
  end

  context 'Class Methods' do
    it 'Should create a credit card transaction' do
      recharge = Recharge.generate_credit_cad(@recharge)
      expect(recharge.pagseguro_payment_method).to eq('credit_card')
    end

    it 'Should create a billet transaction' do
      recharge = Recharge.generate_billet(@recharge)
      expect(recharge.pagseguro_payment_method).to eq('billet')
    end

    it 'Should create a debit online transaction' do
      recharge = Recharge.generate_debit_online(@recharge)
      expect(recharge.pagseguro_payment_method).to eq('debit_online')
    end
  end

  context 'Instance Methods' do
    it { expect { create(:recharge) }.to change { PagseguroHistory.all.size }.by(1) }
  end
end
