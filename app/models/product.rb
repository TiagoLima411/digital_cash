class Product < ApplicationRecord
  belongs_to :Category
  belongs_to :Invoice
end
