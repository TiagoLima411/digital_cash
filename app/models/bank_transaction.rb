class BankTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :benefited_user, foreign_key: :benefited_user_id, class_name: "User"
  has_many :nobe_revenues

  after_create :generate_income_to_benefited_user, :generate_outgoing_to_current_user, :generate_revenues, :calculate_spread
  before_validation :check_balance, on: :create

  enum status: %i[approved pending canceled]

  def generate_income_to_benefited_user
    Income.generate_credit(self)
  end

  def generate_outgoing_to_current_user
    Outgoing.generate_debit(self)
  end

  def generate_revenues
    NobeRevenue.generate(self)
  end

  def check_balance
    if self.user.account_balance.available_value_cents < self.gross_value_cents 
			self.errors.add(:base, "Saldo insuficiente para completar a transação!" )
		end
  end

  def calculate_spread
    self.spread_fee_cents = RateSetting.get_rate_at_day_week(DateTime.now)
    self.spread_fee_cents = self.spread_fee_cents + 1000 if self.net_value_cents > 100000
  end
end
