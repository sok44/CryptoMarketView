class CreateCurrencyPairs < ActiveRecord::Migration[5.1]
  def change
    create_table :currency_pairs do |t|
      t.string :name
      t.references :base_currency, foreign_key: { to_table: :currencies  }, index: true
      t.references :quote_currency, foreign_key: { to_table: :currencies }, index: true
      
      t.timestamps
    end
  end
end
