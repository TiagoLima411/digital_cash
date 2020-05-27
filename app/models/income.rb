class Income < ApplicationRecord
  belongs_to :user

  after_create :generate_history
  before_save :update_account_balance, if: -> { new_record? }

  monetize :value_cents
  
  enum intype: %i[deposit transfer]
  
  def generate_history
    AccountExtract.generate_credit(self)
  end

  def update_account_balance
    balance = AccountBalance.find_by(user_id: self.user_id)
    balance.with_lock do
      balance.update(available_value_cents: balance.available_value_cents + self.value_cents) if self.intype.eql?("deposit")
    end
  end
end
