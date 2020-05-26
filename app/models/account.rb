class Account < ApplicationRecord
  belongs_to :bank
  belongs_to :user

  enum account_type: %i[cc cp]
end
