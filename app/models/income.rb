class Income < ApplicationRecord
  belongs_to :user

  after_create :generate_history
  before_save :update_account_balance, if: -> { new_record? }

  monetize :value_cents
  
  enum intype: %i[deposit transfer]

  def self.generate_credit(bank_transaction)
    net_value = format_value_cents(bank_transaction.net_value_cents) 

    income = Income.new
    income.user = bank_transaction.benefited_user
    income.intype = Income.intypes[:transfer]
    income.value_cents = bank_transaction.net_value_cents
    income.description = "Valor recebido de R$#{net_value} de #{bank_transaction.user.member.name}"
    income.reference_id = bank_transaction.id
    income.save

  end
  
  def generate_history
    AccountExtract.generate_credit(self)
  end

  def update_account_balance
    balance = AccountBalance.find_by(user_id: self.user_id)
    balance.with_lock do
      balance.update(available_value_cents: balance.available_value_cents + self.value_cents) if self.intype.eql?("deposit") || self.intype.eql?("transfer")
    end
  end

  private

  def self.format_value_cents(value_cents)
    value = '%.2f' % (value_cents.to_f / 100)
    return value.gsub('.', ',')
  end
end
