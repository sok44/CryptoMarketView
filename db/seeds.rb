# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Market.create([{name: 'HitBTC', website: 'www.hitbtc.com', adapter_name: 'hitbtc'}, {name: 'BITFINEX', website: 'www.bitfinex.com', adapter_name: 'bitfinex'}, {name: 'Сryptopia', website: 'www.cryptopia.co.nz', adapter_name: ''}])

Currency.create([{short_name: 'BTC', full_name: 'Bitcoin', crypto: true, description: '1', tick_precision: 100000000, volume_precision: 100000000}, {short_name: 'ETH', full_name: 'Ethereum', crypto: true, description: '2', tick_precision: 100000000, volume_precision: 100000000}, {short_name: 'XMR', full_name: 'Monero', crypto: true, description: '', tick_precision: 1000000, volume_precision: 1000000}])

CurrencyPair.create([{name: 'ETHBTC', base_currency_id: 2, quote_currency_id: 1}, {name: 'XMRBTC', base_currency_id: 3, quote_currency_id: 1}])

MarketCurrencyPairName.create([{market_id: 1, currency_pair_id: 1, name: 'ETHBTC'}, {market_id: 2, currency_pair_id: 1, name: 'tETHBTC'}, {market_id: 3, currency_pair_id: 1, name: 'ETH_BTC'}, {market_id: 1, currency_pair_id: 2, name: 'XMRBTC'}, {market_id: 2, currency_pair_id: 2, name: 'tXMRBTC'}])

TimeInterval.create([{ name: 'second' }, { name: 'minute' }, { name: 'hour' }, { name: 'day' }, { name: 'week' }, { name: 'month' }, { name: 'year' }])

PeriodQuotationType.create([{short_name: 'M1', long_name: '1 minute', time_interval_id: 2, count_intervals: 1}, {short_name: 'M5', long_name: '5 minutes', time_interval_id: 2, count_intervals: 5}, {short_name: 'M15', long_name: '15 minutes', time_interval_id: 2, count_intervals: 15}, {short_name: 'M30', long_name: '30 minutes', time_interval_id: 2, count_intervals: 30}, {short_name: 'H1', long_name: '1 hour', time_interval_id: 3, count_intervals: 1}, {short_name: 'H3', long_name: '3 hours', time_interval_id: 3, count_intervals: 3}, {short_name: 'H4', long_name: '4 hours', time_interval_id: 3, count_intervals: 4}, {short_name: 'D1', long_name: '1 day', time_interval_id: 4, count_intervals: 1}, {short_name: 'W1', long_name: '1 week', time_interval_id: 5, count_intervals: 1}, {short_name: 'MN1', long_name: '1 month', time_interval_id: 6, count_intervals: 1}, {short_name: 'Y1', long_name: '1 year', time_interval_id: 7, count_intervals: 1}])

MarketPeriodName.create([{market_id: 1, period_quotation_type_id: 1, name: 'M1'}, {market_id: 1, period_quotation_type_id: 5, name: 'H1'}, {market_id: 1, period_quotation_type_id: 7, name: 'H4'}, {market_id: 1, period_quotation_type_id: 8, name: 'D1'}, {market_id: 1, period_quotation_type_id: 10, name: '1M'}, {market_id: 2, period_quotation_type_id: 1, name: '1m'}, {market_id: 2, period_quotation_type_id: 5, name: '1h'}, {market_id: 2, period_quotation_type_id: 6, name: '3h'}, {market_id: 2, period_quotation_type_id: 8, name: '1D'}, {market_id: 2, period_quotation_type_id: 10, name: '1M'}])

