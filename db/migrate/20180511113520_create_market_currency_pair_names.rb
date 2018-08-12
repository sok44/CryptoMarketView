class CreateMarketCurrencyPairNames < ActiveRecord::Migration[5.1]
  def change
    create_table :market_currency_pair_names do |t|
      t.references :market, foreign_key: { to_table: :markets }, index: true
      t.references :currency_pair, foreign_key: { to_table: :currency_pairs }, index: true
      t.string :name
      t.timestamps
    end
  end
end
