class Product < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :invoice, optional: true
  has_one :inventory

  before_save :set_spread
  after_create :create_inventory

  monetize :sale_price_cents
  monetize :purchase_price_cents

  private

  def set_spread
    self.spread_cents = sale_price_cents - purchase_price_cents
    self.spread_fee = ((spread_cents * 100) / purchase_price_cents).to_d
  end

  def create_inventory
    inventory = Inventory.new
    inventory.product = self
    inventory.amount = 0
    inventory.save
  end
end
