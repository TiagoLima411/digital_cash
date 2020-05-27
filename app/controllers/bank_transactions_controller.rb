class BankTransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @bank_transaction = BankTransaction.new
  end

  def create
    @bank_transaction = BankTransaction.new(bank_transaction_params)

    respond_to do |format|
      if @bank_transaction.save
        format.html { redirect_to dashboard_path, notice: 'Depósito efetuado com sucesso.' }
        format.json { render :show, status: :created, location: @bank_transaction }
      else
        format.html { render :new }
        format.json { render json: @bank_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    
  # Never trust parameters from the scary internet, only allow the white list through.
  def bank_transaction_params
    params.require(:bank_transaction).permit(:id, :user_id, :benefited_user_id, :spread_fee_cents, :net_value_cents, :gross_value_cents, :description, :status)
  end

end
