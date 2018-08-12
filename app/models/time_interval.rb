class TimeInterval < ApplicationRecord
  has_many :period_quotation_types

  validates :name, presence: true
end
