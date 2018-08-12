class AddUniqueIndexToQuotations < ActiveRecord::Migration[5.1]
  def change
    add_index :quotations, [:market_id, :currency_pair_id, :period_quotation_type_id, :datetime_tick], unique: true, name: 'unique_by_market_symbol_period_date'
  end
end
