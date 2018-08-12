class Quotation < ApplicationRecord
  belongs_to :currency_pair
  belongs_to :market
  belongs_to :period_quotation_type

  validates :currency_pair_id, presence: true
  validates :market_id, presence: true
  validates :period_quotation_type_id, presence: true
  
  validates :datetime_tick, presence: true
  
  validates :open_tick, presence: true
  validates :open_tick, numericality: { only_integer: true, greater_than: 0 }
  validates :high_tick, presence: true
  validates :high_tick, numericality: { only_integer: true, greater_than: 0 }
  validates :low_tick, presence: true
  validates :low_tick, numericality: { only_integer: true, greater_than: 0 }
  validates :close_tick, presence: true
  validates :close_tick, numericality: { only_integer: true, greater_than: 0 }
  validates :volume_tick, presence: true
  validates :volume_tick, numericality: { only_integer: true, greater_than: 0 }
  # Добавить валидацию на уникальность

  scope :first_count, -> (count) { first(count) if count.present? }
  scope :where_market, -> (market_id) { where(market_id: market_id) if market_id.present? }
  scope :where_currency_pair, -> (currency_pair_id) { where(currency_pair_id: currency_pair_id) if currency_pair_id.present? }
  scope :where_period_quotation_type, -> (period_quotation_type_id) { where(period_quotation_type_id: period_quotation_type_id) if period_quotation_type_id.present? }
  scope :where_datetime_tick, -> (select_datetimes) { where(datetime_tick: select_datetimes) if select_datetimes.present? }
  scope :order_updated_desc, -> (direction) { order(datetime_tick: direction) if direction.present? }
end
