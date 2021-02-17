class RechargesController < ApplicationController
	
	def new
		@recharge = Recharge.new
	end

	def create
		@recharge = Recharge.new(recharge_params)
		respond_to do |format|
			if @recharge.save
				flash[:success] = 'Recarga criada com sucesso.'
				format.html { render :new }
			else
				flash[:error] = 'Erro ao criar recarga.'
				format.html { render :new  }
			end
		end
	end

	private

	def recharge_params
		params.require(:recharge).permit(
			:id,
			:user_id,
			:pagseguro_payment_method,
			:pagseguro_status,
			:gross_value_cents,
			:discount_value_cents,
			:installment_fee_amount,
			:intermediation_rate_amount,
			:intermediation_fee_amount,
			:net_value_cents,
			:extra_value_cents,
			:installment_count,
			:item_count,
			:code,
			:payment_method_code,
			:authorizationCode,
			:nsu,
			:tid,
			:establishment_code,
			:acquirer_Name,
			:primary_receiver_key,
			:date,
			:transaction_date,
			:last_event_date
		)
	end
end
