class MarketsController < ApplicationController

def index
    @markets = Market.all
  end

  def show
    @market = Market.find(params[:id])
  end

  def new
    @market = Market.new
  end

  def edit
    @market = Market.find(params[:id])
  end

  def create
    @market = Market.new(market_params)

    if @market.save
      redirect_to @market
    else
      render 'new'
    end
  end

  def update
    @market = Market.find(params[:id])

    if @market.update(market_params)
      redirect_to @market
    else
      render 'edit'
    end
  end

  def destroy
    @market = Market.find(params[:id])
    @market.destroy

    redirect_to markets_path 
  end

  private

  def market_params
    params.require(:market).permit(:name, :website, :adapter_name)
  end

end
