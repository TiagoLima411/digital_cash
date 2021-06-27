json.extract! product, :id, :Category_id, :Invoice_id, :name, :bar_code, :purchase_price, :sale_price, :spread, :spread_fee, :created_at, :updated_at
json.url product_url(product, format: :json)
