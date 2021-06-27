class ProductSerializer < ApplicationSerializer
  attributes :id, :name, :bar_code, :purchase_price, :sale_price, :spread, :spread_fee
  has_one :Category
  has_one :Invoice
end
