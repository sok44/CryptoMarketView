FactoryBot.define do
  factory :market_symbol_precision do  
    association :currency_pair
    association :market
    tick_precision '1000000'
    volume_precision '10000000'
  end
end