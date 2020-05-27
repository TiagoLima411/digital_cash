class Outgoing < ApplicationRecord
  belongs_to :user

  after_create :update_account_balance, :generate_history
  
  monetize :value_cents
  
  enum outtype: %i[with_draw transfer]

  def self.generate_debit(bank_transaction)
    net_value = format_value_cents(bank_transaction.net_value_cents) 

    outgoing = Outgoing.new
    outgoing.user = bank_transaction.user
    outgoing.outtype = Outgoing.outtypes[:transfer]
    outgoing.value_cents = bank_transaction.net_value_cents
    outgoing.description = "Transferido o valor de R$#{net_value} para #{bank_transaction.benefited_user.member.name}"
    outgoing.reference_id = bank_transaction.id
    outgoing.save
  end
  
  def generate_history
    AccountExtract.generate_debit(self)
  end

  def update_account_balance
    balance = AccountBalance.find_by(user_id: self.user_id)
    balance.with_lock do
      balance.update(available_value_cents: balance.available_value_cents - self.value_cents) if self.outtype.eql?("with_draw") || self.outtype.eql?("transfer")
    end
  end

  private

  def self.format_value_cents(value_cents)
    value = '%.2f' % (value_cents.to_f / 100)
    return value.gsub('.', ',')
  end
end
