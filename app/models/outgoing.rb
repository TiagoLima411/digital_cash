class Outgoing < ApplicationRecord
  belongs_to :user

  after_create :update_account_balance, :generate_history
  
  monetize :value_cents
  
  enum outtype: %i[with_draw transfer]
  
  def generate_history
    AccountExtract.generate_debit(self)
  end

  def update_account_balance
    balance = AccountBalance.find_by(user_id: self.user_id)
    balance.with_lock do
      balance.update(available_value_cents: balance.available_value_cents - self.value_cents) if self.outtype.eql?("with_draw")
    end
  end
end
