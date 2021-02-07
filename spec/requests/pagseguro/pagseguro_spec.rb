require 'rails_helper'

RSpec.describe 'Pagseguro', type: :request do
  let(:url_base) { 'https://ws.sandbox.pagseguro.uol.com.br/v2' }
  let(:auth) { auth_params }

  describe 'Sandbox Pagseguro integration' do
    context 'POST /sessions' do
      it 'responds with session id present' do
        response = HTTParty.post("#{url_base}/sessions?email=#{auth[:email]}&token=#{auth[:token]}")
        expect(response['session']['id'].present?).to eq(true)
      end
    end
  end

  def auth_params
    {
      email: Rails.application.credentials[Rails.env.to_sym][:email],
      token: Rails.application.credentials[Rails.env.to_sym][:pag_seguro_test_token]
    }
  end
end
