class MarketSymbolPrecisionsController < ApplicationController

  def index
    @market_symbol_precisions = MarketSymbolPrecision.all
  end

  def show
    @market_symbol_precision = MarketSymbolPrecision.find(params[:id])
  end

  def new 
    @market_symbol_precision = MarketSymbolPrecision.new
  end

  def edit
    @market_symbol_precision = MarketSymbolPrecision.find(params[:id])
  end

  def create
    @market_symbol_precision = MarketSymbolPrecision.new(market_symbol_precision_params)

    if @market_symbol_precision.save
      redirect_to @market_symbol_precision
    else
      render 'new'
    end
  end

  def update
    @market_symbol_precision = MarketSymbolPrecision.find(params[:id])

    if @market_symbol_precision.update(market_symbol_precision_params)
      redirect_to @market_symbol_precision
    else
      render 'edit'
    end
  end

  def destroy
    @market_symbol_precision = MarketSymbolPrecision.find(params[:id])
    @market_symbol_precision.destroy

    redirect_to market_symbol_precisions_path
  end

  private

  def market_symbol_precision_params
    params.require(:market_symbol_precision).permit(:currency_pair_id, :market_id, :tick_precision, :volume_precision)
  end

end
