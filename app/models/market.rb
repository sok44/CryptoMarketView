class Market < ApplicationRecord
  has_many :market_period_names
  has_many :market_symbol_precisions
  has_many :quotations
  
  validates :name, presence: true
  validates :website, presence: true
end
