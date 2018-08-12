FactoryBot.define do
  factory :currency_pair do
    name 'ETHBTC'
    association :base_currency, factory: :currency
    association :quote_currency, factory: :currency, short_name: 'ETH', full_name: 'Ethereum' 
  end
end