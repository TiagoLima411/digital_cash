class SessionPaymentsController < ApplicationController
  before_action :authenticate_user!

  def middleware_payment_password
  end

  def verify_payment_password
    payment_password = false #User.valid_payment_password(params[:cpf], params[:payment_password])

    respond_to do |format|
      if payment_password
        format.html { redirect_to new_outgoing_path }
      else
        format.html { redirect_to '/payment_password', notice: 'Senha incorreta.' }
      end
    end
  end
end
