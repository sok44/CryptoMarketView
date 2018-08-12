class AddAdapterNameToMarkets < ActiveRecord::Migration[5.1]
  def change
    add_column :markets, :adapter_name, :string
  end
end
