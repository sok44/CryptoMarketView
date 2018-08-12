module Hitbtc
  class HitbtcAdapter
    require 'uri'
    require 'net/http'
    require 'json'

    def self.request_currency_pair_last_quotations(market_period_name:, market_currency_pair_name:, count_request_quotation:, market_id: nil, currency_pair_id: nil, period_quotation_type_id: nil)

      request_quotations = []
      
      host = 'api.hitbtc.com'
      path = "/api/2/public/candles/#{market_currency_pair_name}"
      params = { period: market_period_name, limit: count_request_quotation} 

      query = URI.encode_www_form(params)

      uri = URI::HTTPS.build(host: host, path: path, query: query)

      response = Net::HTTP.get_response(uri)
      
      if response.is_a?(Net::HTTPSuccess)
        
        JSON.parse(response.body).each do |response_element|

          quotation_params = {}
          quotation_params[:market_id] = market_id
          quotation_params[:currency_pair_id] = currency_pair_id
          quotation_params[:period_quotation_type_id] = period_quotation_type_id

          deserialize(response_element, quotation_params)   
          
          request_quotations << quotation_params
        end
  
      end

      request_quotations
    end

    def self.deserialize(response, quotation_params) 
      quotation_params[:datetime_tick] = DateTime.iso8601(response['timestamp'])
      quotation_params[:open_tick] = response['open']
      quotation_params[:high_tick] = response['max']
      quotation_params[:low_tick] = response['min']
      quotation_params[:close_tick] = response['close']
      quotation_params[:volume_tick] = response['volume']
    end

  end
end