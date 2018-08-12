class QuotationsController < ApplicationController

  def index    

    if params[:quotation].nil?
      @quotation = Quotation.new 
      @quotation.period_quotation_type_id = PeriodQuotationType.where(short_name: 'D1').first.id

    else
      @quotation = Quotation.new(quotations_filters_params)
    end

    @quotations = Quotations::QuotationsSelect.new(10, @quotation.currency_pair_id, @quotation.market_id, @quotation.period_quotation_type_id).call
  end

  def show
    quotation = Quotation.find(params[:id])
    @quotation = Quotations::QuotationDecorator.new(quotation)
  end

  def new
    @quotation = Quotation.new   
  end

  def edit
    quotation = Quotation.find(params[:id])
    @quotation = Quotations::QuotationDecorator.new(quotation)
  end

  def create
    @quotation = Quotation.new
  
    if Quotations::QuotationSave.new(@quotation, quotation_params).call
      redirect_to @quotation
    else
      render 'new'
    end  
  end

  def update
    @quotation = Quotation.find(params[:id])

    #if @quotation.update(quotation_params)
    if Quotations::QuotationSave.new(@quotation, quotation_params).call
      redirect_to @quotation
    else
      render 'edit'
    end
  end

  def destroy
    @quotation = Quotation.find(params[:id])
    @quotation.destroy

    redirect_to quotations_path
  end

  private

  def quotations_filters_params
     
     params.require(:quotation).permit(:market_id, :currency_pair_id, :period_quotation_type_id)
   
  end

  def quotation_params
    params.require(:quotation).permit(:market_id, :currency_pair_id, :period_quotation_type_id, :mts_tick, :open_tick, :high_tick, :low_tick, :close_tick, :volume_tick, :datetime_tick)
  end

end
