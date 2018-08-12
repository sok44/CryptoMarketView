FactoryBot.define do
  factory :quotation do
    association :market
    association :currency_pair
    association :period_quotation_type
    datetime_tick "2018-07-16"
    open_tick 7076000
    high_tick 7183100
    low_tick 7017000
    close_tick 7120400
    volume_tick 49558547000000
  end
end