class CurrencyPair < ApplicationRecord
  belongs_to :base_currency, class_name: 'Currency', foreign_key: 'base_currency_id'
  belongs_to :quote_currency, class_name: 'Currency', foreign_key: 'quote_currency_id'

  has_many :market_symbol_precisions
  has_many :quotations
  
  validates :name, presence: true
  validates :base_currency_id, presence: true
  validates :quote_currency_id, presence: true
end
