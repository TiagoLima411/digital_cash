# frozen_string_literal: true

class Inventory < ApplicationRecord
  belongs_to :product
  attr_accessor :amount_to_extract

  def self.generate_debit(params, logged_use)
    inventory = Inventory.find_by(product_id: params[:product_id])
    return if inventory.nil?

    Inventory.transaction do
      inventory.amount_to_extract = params[:amount].to_i if params[:amount].to_i > 0
      inventory.amount += params[:amount].to_i

      generate_extract(inventory, logged_use)
      inventory.save
      return inventory
    end
  end

  def self.generate_extract(inventory, logged_use)
    Outgoing.generate_debit(inventory, logged_use)
  end
end
