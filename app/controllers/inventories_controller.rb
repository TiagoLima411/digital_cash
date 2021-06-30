class InventoriesController < ApplicationController

  def index
    @products = Inventory.all
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    respond_to do |format|
      if @inventory.save
        format.html { redirect_to new_inventory_path, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  def inventory_params
    params
      .require(:inventory)
      .permit(
        :product_id,
        :amount,
      )
  end
end
