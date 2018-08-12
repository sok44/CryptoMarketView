class CreatePeriodQuotationTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :period_quotation_types do |t|
      t.string :short_name
      t.string :long_name
      t.references :time_interval, foreign_key: true
      t.integer :count_intervals
    end
  end
end
