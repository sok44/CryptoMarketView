class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string :short_name
      t.string :full_name
      t.boolean :crypto
      t.string :description
      t.integer :tick_precision, limit: 8
      t.integer :volume_precision, limit: 8
      t.timestamps
    end
  end
end
