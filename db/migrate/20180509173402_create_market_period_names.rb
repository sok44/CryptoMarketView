class CreateMarketPeriodNames < ActiveRecord::Migration[5.1]
  def change
    create_table :market_period_names do |t|
      t.references :market, foreign_key: { to_table: :markets }, index: true
      t.references :period_quotation_type, foreign_key: { to_table: :period_quotation_types }, index: true
      t.string :name
      t.timestamps
    end
  end
end
