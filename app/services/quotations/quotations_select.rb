module Quotations
  class QuotationsSelect    
  
    attr_reader :count_last_quotations, :currency_pair_id,  :market_id, :period_quotation_type_id 

    def initialize(count_last_quotations, currency_pair_id, market_id, period_quotation_type_id)
      @count_last_quotations = count_last_quotations
      @currency_pair_id = currency_pair_id
      @market_id = market_id
      @period_quotation_type_id = period_quotation_type_id
    end

    def call   
      quotations_select
    end

    private

    def quotations_select

      return_quotations = []

      #Подготовка запрашиваемых дат 
      select_datetimes = preparation_selected_date()

      #Подготовка данных по биржам и валютным парам
      if currency_pair_id.nil?
        currency_pairs = CurrencyPair.select(:id).distinct
      else
        currency_pairs = CurrencyPair.where(id: currency_pair_id).select(:id).distinct
      end

      if market_id.nil?
        markets = Market.select(:id, :adapter_name).where.not(adapter_name: [nil, ""]).distinct 
      else
        markets = Market.where(id: market_id).where.not(adapter_name: [nil, ""]).select(:id, :adapter_name).distinct 
      end  

      #byebug

      #Запрашиваем даные из БД с отбором по выбранным датам, биржам и валютным парам
      markets.each do |market|
        currency_pairs.each do |currency_pair|

          #В 99,9999% случаях перед запросом данных данные уже будут в базе, поэтому имеет смысл запросить все требуемые данные
          quotations = Quotation.where_market(market.id).where_currency_pair(currency_pair.id).where_period_quotation_type(period_quotation_type_id).where_datetime_tick(select_datetimes).order_updated_desc(:desc).map{|quotation| Quotations::QuotationDecorator.new(quotation)}

          if quotations.count == count_last_quotations
            Rails.logger.tagged('QuotationsSelect', 'Completed') { Rails.logger.debug {"Все котировки выбраны из БД."} }
            byebug
            return_quotations.concat(quotations)
          elsif quotations.count < count_last_quotations

            #т.к. скорее всего котировки будут за все дни кроме последнего то имеет смысл сделать пред запрос только последнего дня, и если котировок не хватает делать уже запрос всех данных с бирж, за все дни.

            Rails.logger.tagged('QuotationsSelect', 'DBDataMissing') { Rails.logger.debug {"Запуск запроса котировок у бирж."} }       

            request_quotations = Quotations::QuotationsRequestFromMarket.new(adapter_name: market.adapter_name, market_id: market.id, currency_pair_id: currency_pair.id, period_quotation_type_id: period_quotation_type_id, count_last_quotations: count_last_quotations).call
 
            Rails.logger.tagged('QuotationsSelect', 'DBDataMissing') { Rails.logger.debug {"Сохряняем полученные у бирж данные в БД:"} }     
            
            select_datetimes.each do |select_datetime|   
              if quotations.find {|quotation| quotation.datetime_tick == select_datetime} == nil
                
                request_quotation = request_quotations.find {|request_quotation| request_quotation[:datetime_tick] == select_datetime}
                if !request_quotation.nil?
                  #Можно сделать обший insert с игнорированием дибулей вместо new-save
                  Quotations::QuotationsSave.new(Quotation.new, request_quotation).call
                end
              end   
            end
            
            #В 99,9999% случаях перед запросом данных данные уже будут в базе, поэтому данный повторный запрос будет запускаться один раз для конкретных паратметров запроса
            byebug

            quotations = Quotation.where_market(market.id).where_currency_pair(currency_pair.id).where_period_quotation_type(period_quotation_type_id).where_datetime_tick(select_datetimes).order_updated_desc(:desc).map{|quotation| Quotations::QuotationDecorator.new(quotation)}
            return_quotations.concat(quotations)   
          else
            Rails.logger.tagged('QuotationsSelect', 'DuplicateError') { Rails.logger.debug {"Задвоение котировок в БД."} }
          end
        end
      end

      return return_quotations
    end

    #Подготовка запрашиваемых дат
    def preparation_selected_date 
      select_datetimes = []
      start_datetime = DateTime.current().utc()

      period_quotation_type = PeriodQuotationType.find(period_quotation_type_id)
      count_intervals = period_quotation_type.count_intervals

      if period_quotation_type.time_interval.name.downcase() == 'day'  
        
        start_datetime = start_datetime.beginning_of_day

        #Заполняем массив дат
        1.upto(count_last_quotations) do |i|
          select_datetimes << start_datetime - i.day
        end

      elsif period_quotation_type.time_interval.name.downcase() == 'hour'
        
        count_time = (start_datetime.to_time - start_datetime.beginning_of_day.to_time) / 1.hours
        count_time = (count_time / count_intervals).to_i * count_intervals

        start_datetime = (start_datetime.beginning_of_day.to_time + count_time.hours).to_datetime

        #byebug
        #Заполняем массив дат
        1.upto(count_last_quotations) do |i|
          select_datetimes << start_datetime.to_time - (i * count_intervals).hours
        end
      else
        start_datetime = start_datetime.beginning_of_day

        #Заполняем массив дат
        1.upto(count_last_quotations) do |i|
          select_datetimes << start_datetime - i.day
        end
      end

      select_datetimes
    end

  end
end