FactoryBot.define do
  factory :account_extract do
    user { nil }
    account_banlance { nil }
    value_cents { 1 }
    balance_cents { 1 }
    description { "MyString" }
    type_register { 1 }
  end
end
