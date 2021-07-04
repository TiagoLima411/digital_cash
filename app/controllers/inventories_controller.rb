class InventoriesController < ApplicationController
  def index
    @products = Inventory.all
  end

  def new
    @inventory = Inventory.new
  end

  def create
    respond_to do |format|
      @inventory = Inventory.generate_debit(inventory_params, current_user) if params[:kind].eql?('income')
      @inventory = Inventory.generate_credit(inventory_params, current_user) if params[:kind].eql?('outgoing')
      if @inventory
        format.html { redirect_to new_inventory_path, notice: 'O Estoque foi atualizado com sucesso.' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def inventory_params
    params
      .require(:inventory)
      .permit(
        :product_id,
        :amount
      )
  end
end
