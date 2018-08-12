class MarketSymbolPrecision < ApplicationRecord
  belongs_to :currency_pair
  belongs_to :market

  validates :market_id, presence: true
  validates :currency_pair_id, presence: true
  
  validates :tick_precision, numericality: { only_integer: true, greater_than: 0 }
  validates :volume_precision, numericality: { only_integer: true, greater_than: 0 }  

end
