module Quotations::QuotationConversion

  def convert_before_save(value, currency_pair_id, market_id, type_precision)
    
    precision = get_precision(currency_pair_id, market_id, type_precision) 
    return nil if precision.nil? || value.nil?

    #Делитель выбирать исходя из локально устанровленного
    parts = value.to_s.split(".")
    
    integer_part = parts[0]
    fractional_part = parts.count > 1 ? parts[1].to_s : 0

    lenght_fractional_part = fractional_part.size
   
    count_precision = Math.log10(precision)

    add_zero = ""

    if lenght_fractional_part < count_precision
      1.upto(count_precision - lenght_fractional_part) do
        add_zero = add_zero + "0"
      end
      (value.to_s.sub(/\./, "") + add_zero).to_i
    elsif lenght_fractional_part > count_precision
      ((value.to_s.first(value.to_s.length - (lenght_fractional_part - count_precision))).sub(/\./, "")).to_i
    else
      (value.to_s.sub(/\./, "")).to_i
    end

  end

  def convert_before_view(value, currency_pair_id, market_id, type_precision)
    precision = get_precision(currency_pair_id, market_id, type_precision)
    return nil if precision.nil? || value.nil?
    
    value.to_f / precision
  end

  #вынести в глобальный модуль
  def get_precision(currency_pair_id, market_id, type_precision) 

    precision = nil

    ##puts 'currency_pair_id = ' + currency_pair_id.to_s + ', ' + market_id.to_s

    #first search special precision for market symbol precision 
    market_symbol_precision = MarketSymbolPrecision.where(currency_pair_id: currency_pair_id, market_id: market_id).order(updated_at: :desc).first
    #byebug
    unless market_symbol_precision.nil?
      if market_symbol_precision.send(type_precision).present? && market_symbol_precision.send(type_precision) > 0 
        return market_symbol_precision.send(type_precision)
      end
    end

    #byebug
    #if not market symbol precision, then search default precision for quote currency
    
    currency_pair = nil
    currency_pair = CurrencyPair.find_by_id(currency_pair_id) unless currency_pair_id.nil?
    quote_currency = nil
    quote_currency = Currency.find_by_id(currency_pair.quote_currency_id) unless currency_pair.nil?

    if not(quote_currency.nil?) && quote_currency.send(type_precision).present? && quote_currency.send(type_precision) > 0
      precision = quote_currency.send(type_precision)
      ##puts 'precision= ' + precision.to_s
    end

    precision

  end
end
