class Product < ApplicationRecord
  belongs_to :Category, optional: true
  belongs_to :Invoice, optional: true
end
