module Quotations
  class QuotationsRequestFromMarket    
  
    attr_reader :adapter_name, :market_id,  :currency_pair_id, :period_quotation_type_id, :count_last_quotations

    def initialize(adapter_name:, market_id:, currency_pair_id:, period_quotation_type_id:, count_last_quotations:)
      @adapter_name = adapter_name.downcase.capitalize
      @market_id = market_id
      @currency_pair_id = currency_pair_id
      @period_quotation_type_id = period_quotation_type_id
      @count_last_quotations = count_last_quotations    
    end

    def call   
      request_quotations
    end

    private

    def request_quotations
     
      market_currency_pair = MarketCurrencyPairName.where(market_id: market_id, currency_pair_id: currency_pair_id).order(updated_at: :desc).first   
      
      market_period = MarketPeriodName.where(market_id: market_id, period_quotation_type_id: period_quotation_type_id).order(updated_at: :desc).first

      if not(market_currency_pair.nil?) && not(market_period.nil?) 

        function_string = "#{adapter_name}::#{adapter_name}Adapter.request_currency_pair_last_quotations(market_period_name: '#{market_period.name}', market_currency_pair_name: '#{market_currency_pair.name}', count_request_quotation: #{count_last_quotations + 1}, market_id: #{market_id}, currency_pair_id: #{currency_pair_id}, period_quotation_type_id: #{period_quotation_type_id})"

        eval(function_string)
      else
        []
      end
    end

  end
end