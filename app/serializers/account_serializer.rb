class AccountSerializer < ApplicationSerializer
  attributes :id, :agency_number, :account_number, :account_type
  has_one :bank
  has_one :user
end
