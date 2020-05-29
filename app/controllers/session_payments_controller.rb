class SessionPaymentsController < ApplicationController
  before_action :authenticate_user!

  def middleware_payment_password
    if is_defined_param?(:cpf) && is_defined_param?(:payment_password)
      check_credentials_outgoing(params[:cpf], params[:payment_password])
    end
  end

end
