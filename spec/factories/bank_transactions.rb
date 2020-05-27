FactoryBot.define do
  factory :bank_transaction do
    user { nil }
    benefited_user { nil }
    spread_fee_cents { 1 }
    net_value_cents { 1 }
    gross_value_cents { 1 }
    status { 1 }
  end
end
