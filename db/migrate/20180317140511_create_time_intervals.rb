class CreateTimeIntervals < ActiveRecord::Migration[5.1]
  def change
    create_table :time_intervals do |t|
      t.string :name
    end
  end
end
