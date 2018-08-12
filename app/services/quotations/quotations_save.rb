module Quotations
  class QuotationsSave    
    include QuotationConversion

    attr_reader :quotation, :params
 
    def initialize(quotation, params)
      @quotation = quotation
      @params = params
    end

    def call
      data_save
    end

    private

    def data_save
      
      params[:open_tick] = convert_before_save(params[:open_tick], params[:currency_pair_id], params[:market_id], :tick_precision)
      params[:high_tick] = convert_before_save(params[:high_tick], params[:currency_pair_id], params[:market_id], :tick_precision)
      params[:low_tick] = convert_before_save(params[:low_tick], params[:currency_pair_id], params[:market_id], :tick_precision)
      params[:close_tick] = convert_before_save(params[:close_tick], params[:currency_pair_id], params[:market_id], :tick_precision)
      params[:volume_tick] = convert_before_save(params[:volume_tick], params[:currency_pair_id], params[:market_id], :volume_precision)

      quotation.assign_attributes(params)
      
      begin
        quotation.save
      rescue ActiveRecord::RecordNotUnique => exception  
        false
      end
      
    end

  end
end