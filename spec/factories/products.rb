FactoryBot.define do
  factory :product do
    Category { nil }
    Invoice { nil }
    name { "MyString" }
    bar_code { "" }
    purchase_price { 1 }
    sale_price { 1 }
    spread { 1 }
    spread_fee { "9.99" }
  end
end
