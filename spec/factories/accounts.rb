FactoryBot.define do
  factory :account do
    bank { nil }
    agency_number { "MyString" }
    account_number { "MyString" }
    account_type { 1 }
  end
end
