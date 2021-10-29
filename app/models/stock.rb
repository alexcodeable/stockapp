class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  validates :symbol, :company, presence: true
  before_save { self.symbol.downcase!}

  extend FriendlyId
  friendly_id :company, use: :slugged

  def self.new_lookup(stock_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_key[:iex_id],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )    
    
    begin
      new(symbol: stock_symbol, last_price: client.price(stock_symbol), company: client.company(stock_symbol).company_name )
    rescue => exception
      return nil
    end
  end

  def self.check_db(stock_symbol)
    where(symbol: stock_symbol).first
  end
end

