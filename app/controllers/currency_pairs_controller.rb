class CurrencyPairsController < ApplicationController

  def index
    @currency_pairs = CurrencyPair.all
  end

  def show
    @currency_pair = CurrencyPair.find(params[:id])
  end

  def new
    @currency_pair = CurrencyPair.new
  end

  def edit
    @currency_pair = CurrencyPair.find(params[:id])
  end

  def create
    @currency_pair = CurrencyPair.new(currency_pair_params)

    if @currency_pair.save
      redirect_to @currency_pair
    else
      render 'new'
    end
  end

  def update
    @currency_pair = CurrencyPair.find(params[:id])

    if @currency_pair.update(currency_pair_params)
      redirect_to @currency_pair
    else
      render 'edit'
    end
  end

  def destroy
    @currency_pair = CurrencyPair.find(params[:id])
    @currency_pair.destroy

    redirect_to currency_pairs_path
  end

  private

  def currency_pair_params
    params.require(:currency_pair).permit(:name, :base_currency_id, :quote_currency_id)
  end

end
