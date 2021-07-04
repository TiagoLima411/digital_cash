class Income < ApplicationRecord
  belongs_to :user

  after_create :generate_history
  before_save :update_account_balance, if: -> { new_record? }

  monetize :value_cents

  enum intype: %i[inventory payment]

  scope :incomes_in_month, ->(date) {
    where(created_at: [date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day])
  }

  def self.generate_credit(inventory, logged_user)
    income = Income.new
    income.user = logged_user
    income.intype = Income.intypes[:inventory]
    income.value_cents = (inventory.product.sale_price_cents * inventory.amount_to_extract).to_i
    income.description = "Venda de #{inventory.amount_to_extract} de #{inventory.product.name}"
    income.reference_id = inventory.product.id
    income.save

  end

  def self.generate_credit_card(recharge_credit_card)
    net_value = format_value_cents(recharge_credit_card.net_value_cents)

    income = Income.new
    income.user = recharge_credit_card.user
    income.intype = :recharge_credit_card
    income.value_cents = recharge_credit_card.net_value_cents
    income.description = recharge_credit_card.description
    income.reference_id = recharge_credit_card.id

    income.save

  end

  def generate_history
    AccountExtract.generate_credit(self)
  end

  def update_account_balance
    balance = AccountBalance.find_by(user_id: self.user_id)
    balance.with_lock do
      if inventory?
        balance.update(available_value_cents: balance.available_value_cents + self.value_cents)
      end
    end
  end

  private

  def self.format_value_cents(value_cents)
    value = '%.2f' % (value_cents.to_f / 100)
    return value.gsub('.', ',')
  end
end
