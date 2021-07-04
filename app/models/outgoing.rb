class Outgoing < ApplicationRecord
  belongs_to :user

  after_create :update_account_balance, :generate_history
  # validate :check_balance, on: :create

  monetize :value_cents

  enum outtype: %i[inventory payment]

  scope :outgoings_in_month, lambda { |date|
    where(created_at: [date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day])
  }

  # def check_balance
  #   if self.user.account_balance.available_value_cents < self.value_cents
  # 		self.errors.add(:base, "Saldo insuficiente para completar a transação!" )
  # 	end
  # end

  def self.generate_debit(inventory, logged_user)
    outgoing = Outgoing.new
    outgoing.user = logged_user
    outgoing.outtype = Outgoing.outtypes[:inventory]
    outgoing.value_cents = (inventory.product.purchase_price_cents * inventory.amount_to_extract).to_i
    outgoing.description = "Compra de #{inventory.amount_to_extract} #{inventory.product.name}"
    outgoing.reference_id = inventory.product.id
    outgoing.save
  end

  def generate_history
    AccountExtract.generate_debit(self)
  end

  def update_account_balance
    balance = AccountBalance.find_by(user_id: user_id)
    balance.with_lock do
      balance.update(available_value_cents: balance.available_value_cents - value_cents) if outtype.eql?('inventory')
    end
  end

  def self.format_value_cents(value_cents)
    value = format('%.2f', (value_cents.to_f / 100))
    value.gsub('.', ',')
  end
end
