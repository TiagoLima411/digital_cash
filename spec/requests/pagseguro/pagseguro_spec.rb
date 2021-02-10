require 'rails_helper'

RSpec.describe 'Pagseguro', type: :request do
  describe 'Sandbox Pagseguro integration' do
    before(:context) do
      @url_base         = 'https://sandbox.pagseguro.uol.com.br'
      @url_base_ws      = 'https://ws.sandbox.pagseguro.uol.com.br'
      @url_base_helpers = 'https://df.uol.com.br'
      @token            = Rails.application.credentials[Rails.env.to_sym][:pag_seguro_test_token]
      @email            = Rails.application.credentials[Rails.env.to_sym][:email]

      @session          = create_session
      @payment_methods  = get_payment_methods(@session['session']['id'])
      @card_brand       = get_card_brand(@session['session']['id'])
      @card_token       = get_card_token(@session['session']['id'], @card_brand['bin']['brand']['name'])
      @installments     = get_installment_options(@session['session']['id'], @card_brand['bin']['brand']['name'])
      @transaction      = send_card_transaction(@card_token)
    end

    context 'payment api' do
      it 'responds with session id present' do
        expect(@session['session']['id'].present?).to eq(true)
      end

      it 'check payment methods' do
        expect(@payment_methods['paymentMethods']['CREDIT_CARD'].present?).to eq(true)
      end

      it 'check card brand' do
        expect(@card_brand['bin']['brand']['name'].present?).to eq(true)
      end

      it 'check card token' do
        expect(@card_token.present?).to eq(true)
      end

      it 'check installments' do
        expect(@installments['installments'].present?).to eq(true)
      end

      it 'check transaction' do
        expect(@transaction.present?).to eq(true)
      end
    end
  end

  private

  # First step create a session
  def create_session
    app_id = Rails.application.credentials[Rails.env.to_sym][:app_id]
    app_key = Rails.application.credentials[Rails.env.to_sym][:app_key]
    headers = { 'Accept': 'application/vnd.pagseguro.com.br.v3+xml', 'Content-Type': 'application/x-www-form-urlencoded'}
    puts '    Sending request to Pagseguro to create a SESSION, wait a moment ...'
    puts "    Request => #{@url_base_ws}/sessions"
    puts ''
    VCR.use_cassette('pagseguro/session') do
      response = HTTParty.post("#{@url_base_ws}/sessions?appId=#{app_id}&appKey=#{app_key}", headers: headers)
      Hash.from_xml(response.parsed_response.gsub("\n", ''))
    end
  end

  # Second step Get Payments Methods
  def get_payment_methods(session_id)
    headers = { 'Accept': 'application/vnd.pagseguro.com.br.v1+json;charset=ISO-8859-1' }
    puts '    Sending request to Pagseguro to obtain PAYMENT METHODS, wait a moment ...'
    puts "    Request => #{@url_base_ws}/payment-methods"
    puts ''
    VCR.use_cassette('pagseguro/payment_methods') do
      response = HTTParty.get("#{@url_base_ws}/payment-methods?amount=10.00&sessionId=#{session_id}", headers: headers)
      JSON.parse(response)
    end
  end

  # Third step get card brand
  def get_card_brand(session_id)
    first_6_digits = '411111' # Card test
    puts '    Sending request to get CARD DATA, wait a moment ...'
    puts "    Request => #{@url_base_helpers}/df-fe/mvc/creditcard/v1/getBin"
    puts ''
    VCR.use_cassette('pagseguro/card_info') do
      response = HTTParty.get("#{@url_base_helpers}/df-fe/mvc/creditcard/v1/getBin?tk=#{session_id}&creditCard=#{first_6_digits}")
      body = response.body
      JSON.parse(body)
    end
  end

  # Fourth step get card token
  def get_card_token(session_id, brand_name)
    headers = { 'Content-Type': 'application/x-www-form-urlencoded', 'Accept': 'application/json' }
    body = {
      'sessionId': session_id,
      'amount': '11.00',
      'cardNumber': '4111111111111111',
      'cardBrand': brand_name,
      'cardCvv': '123',
      'cardExpirationMonth': '12',
      'cardExpirationYear': '2030'
    }
    puts '    Sending request to get CARD TOKEN, wait a moment ...'
    puts "    Request => #{@url_base_helpers}/v2/cards"
    puts ''
    VCR.use_cassette('pagseguro/card_token') do
      response = HTTParty.post("#{@url_base_helpers}/v2/cards?email=#{@email}&token=#{@token}", body: body, headers: headers)
      return unless response.headers['content-type'] == 'application/json'

      parsed_hash = JSON.parse(response.body)
      return unless response.code == 200 && parsed_hash.key?('token')

      parsed_hash['token']
    end
  end

  # Fifth step get installment options
  def get_installment_options(session_id, brand_name)
    query = {
      'sessionId': session_id,
      'amount': '10.00',
      'creditCardBrand': brand_name
    }
    puts '    Sending request to get CARD INSTALLMENTS, wait a moment ...'
    puts "    Request => #{@url_base}/checkout/v2/installments.json"
    puts ''
    VCR.use_cassette('pagseguro/installments') do
      response = HTTParty.get("#{@url_base}/checkout/v2/installments.json", query: query, verify: false)
      JSON.parse(response.body)
    end
  end

  # Sixth step generate transaction
  def send_card_transaction(card_token)
    headers = { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' }
    body = body_transaction_mock(card_token)
    puts '    Sending request to generate TRANSACTION, wait a moment ...'
    puts "    Request => #{@url_base_ws}/transactions"
    puts ''
    VCR.use_cassette('pagseguro/transaction') do
      response = HTTParty.post("#{@url_base_ws}/transactions/", body: body, headers: headers)
      Hash.from_xml(response.body)
    end
  end

  def body_transaction_mock(card_token)
    {
      'email': @email,
      'token': @token,
      'item[1].id': '1',
      'item[1].description': 'Recargar em conta',
      'item[1].amount': '11.00',
      'item[1].quantity': '1',
      'payment.mode': 'default',
      'payment.method': 'creditCard',
      'currency': 'BRL',
      'sender.name': 'Tiago de Lima Alves',
      'sender.CPF': '16261677026',
      'sender.areaCode': '82',
      'sender.phone': '999999999',
      'sender.email': 'tiago@sandbox.pagseguro.com.br',
      'sender.ip': '187.65.83.78',
      'shipping.address.street': 'Conj. Celly Loureiro, Qd - E',
      'shipping.address.number': '71',
      'shipping.address.district': 'Benedito Bentes',
      'shipping.address.postalCode': '57084-000',
      'shipping.address.city': 'Maceió',
      'shipping.address.state': 'AL',
      'shipping.address.country': 'BRA',
      'creditCard.token': card_token,
      'installment.quantity': '2',
      'installment.value': '5.50',
      'installment.noInterestInstallmentQuantity': '2',
      'creditCard.holder.name': 'Tiago de Lima Alves',
      'creditCard.holder.CPF': '16261677026',
      'creditCard.holder.birthDate': '29/05/1984',
      'creditCard.holder.areaCode': '82',
      'creditCard.holder.phone': '999999999',
      'billingAddress.street': 'Conj. Celly Loureiro, Qd - E',
      'billingAddress.number': '71',
      'billingAddress.district': 'Benedito Bentes',
      'billingAddress.postalCode': '57084000',
      'billingAddress.city': 'Maceió',
      'billingAddress.state': 'AL',
      'billingAddress.country': 'BRA',
      'notificationURL': 'http://localhost:3000/pagseguro/notify'
    }
  end
end
