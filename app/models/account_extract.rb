class AccountExtract < ApplicationRecord
  belongs_to :user
  belongs_to :account_banlance
end
