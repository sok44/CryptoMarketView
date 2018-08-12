class Currency < ApplicationRecord
  has_many :base_currency_pairs, class_name: 'CurrencyPair', foreign_key: 'base_currency_id'
  has_many :quote_currency_pairs, class_name: 'CurrencyPair', foreign_key: 'quote_currency_id'

  validates :full_name, presence: true
  validates :short_name, presence: true
  validates :tick_precision, presence: true
  validates :tick_precision, numericality: { only_integer: true, greater_than: 0 }
  validates :volume_precision, presence: true
  validates :volume_precision, numericality: { only_integer: true, greater_than: 0 }  
end
