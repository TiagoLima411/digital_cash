FactoryBot.define do
  factory :recharge do

    pagseguro_payment_method { 1 } 
    pagseguro_status { 1 }
    gross_value_cents { 1 }
    discount_value_cents { 1 }
    installment_fee_amount { 1.0 }
    intermediation_rate_amount { 1.0 }
    intermediation_fee_amount { 1.0 }
    net_value_cents { 1 }
    extra_value_cents { 1 }
    installment_count { 1 }
    item_count { 1 }
    code { '1' }
    payment_method_code { '1' }
    authorizationCode { '1' }
    nsu { '1' }
    tid { '1' }
    establishment_code { '1' }
    acquirer_Name { '1' }
    primary_receiver_key { '1' }
    date { Time.now }
    transaction_date { Time.now }
    last_event_date { Time.now }

    user
  end
end
