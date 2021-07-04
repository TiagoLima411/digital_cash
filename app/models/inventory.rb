# frozen_string_literal: true

class Inventory < ApplicationRecord
  belongs_to :product

  def self.generate(params, logged_use)
    Inventory.transaction do
      inventory = Inventory.new(params)
      generate_extract(inventory, logged_use) if inventory.save
      return inventory
    end
  end

  def self.generate_extract(inventory, logged_use)
    Outgoing.generate_debit(inventory, logged_use)
  end
end
