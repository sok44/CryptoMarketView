class MarketPeriodNamesController < ApplicationController

  def index
    @market_period_names = MarketPeriodName.all
  end

  def show
    @market_period_name = MarketPeriodName.find(params[:id])
  end

  def new
    @market_period_name = MarketPeriodName.new
  end

  def edit
    @market_period_name = MarketPeriodName.find(params[:id])
  end

  def create
    @market_period_name = MarketPeriodName.new(market_period_name_params)

    if @market_period_name.save
      redirect_to @market_period_name
    else
      render 'new'
    end
  end

  def update
    @market_period_name = MarketPeriodName.find(params[:id])

    if @market_period_name.update(market_period_name_params)
      redirect_to @market_period_name
    else
      render 'edit'
    end
  end

  def destroy
    @market_period_name = MarketPeriodName.find(params[:id])
    @market_period_name.destroy

    redirect_to market_period_names_path
  end

  private

  def market_period_name_params
    params.require(:market_period_name).permit(:market_id, :period_quotation_type_id, :name)
  end

end
