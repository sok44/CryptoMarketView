class MarketPeriodName < ApplicationRecord
  belongs_to :market
  belongs_to :period_quotation_type

  validates :market_id, presence: true
  validates :period_quotation_type_id, presence: true
  validates :name, presence: true
end
