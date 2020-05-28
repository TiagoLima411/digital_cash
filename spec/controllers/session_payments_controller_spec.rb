require 'rails_helper'

RSpec.describe SessionPaymentsController, type: :controller do

  describe "GET #payment_password" do
    it "returns http success" do
      get :payment_password
      expect(response).to have_http_status(:success)
    end
  end

end
