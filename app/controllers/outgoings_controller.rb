class OutgoingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @outgoing = Outgoing.new
    if is_defined_param?(:cpf) && is_defined_param?(:payment_password)
      if valid_payment_user(params[:cpf], params[:payment_password])
        @payment_password = true
        respond_to do |format|
          format.html { render :new } 
        end
      else
        valid_payment_user
      end
    else
      valid_payment_user 
    end
    
  end

  def create
    @outgoing = Outgoing.new(outgoing_params)

    respond_to do |format|
      if @outgoing.save
        format.html { redirect_to dashboard_path, notice: 'Depósito efetuado com sucesso.' }
        format.json { render :show, status: :created, location: @outgoing }
      else
        format.html { render :new }
        format.json { render json: @outgoing.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    
  # Never trust parameters from the scary internet, only allow the white list through.
  def outgoing_params
    params.require(:outgoing).permit(:id, :user_id, :outtype, :value, :description)
  end
end
