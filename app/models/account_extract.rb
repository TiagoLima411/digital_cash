class AccountExtract < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :account_balance

  monetize :value_cents
  monetize :balance_cents
  
  enum type_register: %i[credit debit]

  scope :user_extract, ->(user) { where(user_id: user.id) }

  def self.generate_credit(credit)

    extract = AccountExtract.new
    extract.user = credit.user
    extract.account_balance = credit.user.account_balance
    extract.balance_cents = credit.user.account_balance.available_value_cents
    extract.reference_id = credit.id
    extract.value_cents = credit.value_cents
    extract.description = credit.description
    extract.type_register = AccountExtract.type_registers[:credit]
    extract.save

  end

  def self.generate_debit(debit)
    balance = User.find(debit.user.id).account_balance.available_value_cents

    extract = AccountExtract.new
    extract.account_balance = debit.user.account_balance
    extract.balance_cents = balance
    extract.description = debit.description
    extract.type_register = AccountExtract.type_registers[:debit]
    extract.user = debit.user
    extract.value_cents = debit.value_cents
    extract.reference_id = debit.id
    extract.save

  end

end
