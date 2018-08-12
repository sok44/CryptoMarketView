class CreateQuotations < ActiveRecord::Migration[5.1]
  def change
    create_table :quotations do |t|
      t.references :currency_pair, foreign_key: { to_table: :currency_pairs }, index: true
      t.references :market, foreign_key: { to_table: :markets }, index: true
      t.references :period_quotation_type, foreign_key: { to_table: :period_quotation_types }, index: true
      t.datetime :datetime_tick
      t.integer :open_tick, limit: 8
      t.integer :high_tick, limit: 8
      t.integer :low_tick, limit: 8
      t.integer :close_tick, limit: 8
      t.integer :volume_tick, limit: 8
    end
  end
end
