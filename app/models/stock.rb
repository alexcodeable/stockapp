class Stock < ApplicationRecord
  def self.new_lookup(stock_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_key[:iex_id],
      secret_token: 'Tsk_915472ca1f034b1f80c024e083fdc513',
      endpoint: 'https://sandbox.iexapis.com/v1'
    )    
    
  begin
    new(symbol: stock_symbol, last_price: client.price(stock_symbol), company: client.company(stock_symbol).company_name )
  rescue => exception
    return nil
  end
  end
end

