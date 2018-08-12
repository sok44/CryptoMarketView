FactoryBot.define do
  factory :period_quotation_type do
    short_name 'D1'
    long_name '1 day'
    association :time_interval
    count_intervals 1
  end
end
