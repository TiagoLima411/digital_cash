require 'rails_helper'

RSpec.describe RechargesController, type: :controller do
	it '#new' do
		user = create(:user)
		sign_in user
		get :new, params: {}
		expect(response).to have_http_status(200)
	end
end
