class LoadDataController < ApplicationController

  def new

    market_id = Market.where(name: 'HitBTC').first.id
    currency_pair_id = CurrencyPair.where(name: 'ETHBTC').first.id
    period_quotation_type_id = PeriodQuotationType.where(short_name: 'D1').first.id

    render plain: Quotations::QuotationsSelect.new(10, currency_pair_id, market_id, period_quotation_type_id).call

    #render plain: "OK"
  end

end
