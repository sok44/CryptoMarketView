class PeriodQuotationType < ApplicationRecord
  belongs_to :time_interval
  has_many :market_period_names
  has_many :quotations

  validates :short_name, presence: true
  validates :long_name, presence: true
  validates :time_interval_id, presence: true
  
  validates :count_intervals, presence: true
  validates :count_intervals, numericality: { only_integer: true, greater_than: 0 }
end
