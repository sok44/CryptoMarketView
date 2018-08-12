class CreateMarketSymbolPrecisions < ActiveRecord::Migration[5.1]
  def change
    create_table :market_symbol_precisions do |t|
      t.references :currency_pair, foreign_key: { to_table: :currency_pairs }, index: true
      t.references :market, foreign_key: { to_table: :markets }, index: true
      t.integer :tick_precision, limit: 8
      t.integer :volume_precision, limit: 8
      
      t.timestamps
    end
  end
end
