class MarketCurrencyPairNamesController < ApplicationController

  def index
    @market_currency_pair_names = MarketCurrencyPairName.all
  end

  def show
    @market_currency_pair_name = MarketCurrencyPairName.find(params[:id])
  end

  def new
    @market_currency_pair_name = MarketCurrencyPairName.new
  end

  def edit
    @market_currency_pair_name = MarketCurrencyPairName.find(params[:id])
  end

  def create
    @market_currency_pair_name = MarketCurrencyPairName.new(market_currency_pair_name_params)

    if @market_currency_pair_name.save
      redirect_to @market_currency_pair_name
    else
      render 'new'
    end
  end

  def update
    @market_currency_pair_name = MarketCurrencyPairName.find(params[:id])

    if @market_currency_pair_name.update(market_currency_pair_name_params)
      redirect_to @market_currency_pair_name
    else
      render 'edit'
    end
  end

  def destroy
    @market_currency_pair_name = MarketCurrencyPairName.find(params[:id])
    @market_currency_pair_name.destroy

    redirect_to market_currency_pair_names_path
  end

  private

  def market_currency_pair_name_params
    params.require(:market_currency_pair_name).permit(:market_id, :currency_pair_id, :name)
  end

end
