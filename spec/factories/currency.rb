FactoryBot.define do
  factory :currency do
    short_name 'BTC'
    full_name 'Bitcoin'
    tick_precision '100000000'
    volume_precision '1000000000'
  end
end