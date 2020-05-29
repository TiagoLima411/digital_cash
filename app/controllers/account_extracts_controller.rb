class AccountExtractsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @account_axtracts = AccountExtract.user_extract(current_user)
  end
end
