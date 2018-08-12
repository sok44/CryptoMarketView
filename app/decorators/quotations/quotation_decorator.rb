module Quotations
  class QuotationDecorator < SimpleDelegator
    include Quotations::QuotationConversion

    def open_tick
      convert_before_view(super, currency_pair_id, market_id, :tick_precision)   
    end
    def high_tick
      convert_before_view(super, currency_pair_id, market_id, :tick_precision)   
    end
    def low_tick
      convert_before_view(super, currency_pair_id, market_id, :tick_precision)   
    end
    def close_tick
      convert_before_view(super, currency_pair_id, market_id, :tick_precision)   
    end
    def volume_tick
      convert_before_view(super, currency_pair_id, market_id, :volume_precision)   
    end

  end
end