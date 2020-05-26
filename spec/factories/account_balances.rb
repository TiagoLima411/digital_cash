FactoryBot.define do
  factory :account_balance do
    user { nil }
    available_value_cents { 1 }
  end
end
