class Product < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :invoice, optional: true
end
