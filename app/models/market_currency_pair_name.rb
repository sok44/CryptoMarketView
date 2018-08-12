class MarketCurrencyPairName < ApplicationRecord
  belongs_to :market
  belongs_to :currency_pair

  validates :market_id, presence: true
  validates :currency_pair_id, presence: true
  validates :name, presence: true
end
