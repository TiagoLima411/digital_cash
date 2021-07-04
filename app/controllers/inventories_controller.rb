class InventoriesController < ApplicationController
  def index
    @products = Inventory.all
  end

  def new
    @inventory = Inventory.new
  end

  def create
    respond_to do |format|
      @inventory = Inventory.generate(inventory_params, current_user)
      if @inventory
        format.html { redirect_to new_inventory_path, notice: 'O Produto foi adicionado ao estoque.' }
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
        :amount
      )
  end
end
