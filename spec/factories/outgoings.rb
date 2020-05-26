FactoryBot.define do
  factory :outgoing do
    user { nil }
    outtype { 1 }
    value_cents { 1 }
    description { "MyString" }
  end
end
