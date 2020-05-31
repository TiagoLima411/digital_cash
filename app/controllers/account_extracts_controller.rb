class AccountExtractsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @account_extract = AccountExtract.user_extract(current_user).order(id: :desc)
    @total_available = current_user.account_balance.available_value_cents
    
    if is_defined_param?(:page)
      page = params[:page]
      @account_extract = @account_extract.paginate(page: page, per_page: 10)
    else
      @account_extract = @account_extract.paginate(page: 1, per_page: 10)
    end
  end
end
