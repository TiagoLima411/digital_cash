class Api::UtilsController < ApiController
  skip_before_action :authorize_request, only: [:persist_coins_list]

  def persist_coins_list
    coins_list = Coingecko::Operation.coins_list
    coins_list.each do |coin|
      crypto_currencie = CryptoCurrencie.new(coin_id: coin['id'], symbol: coin['symbol'], name: coin['name']) if CryptoCurrencie.find_by(coin_id: coin['id']).nil?
      crypto_currencie.save
    end
    json_response({ msg: 'Concuído' }, :ok)
  end
end
