class PeriodQuotationTypesController < ApplicationController

  def index
    @period_quotation_types = PeriodQuotationType.all
  end

  def show
    @period_quotation_type = PeriodQuotationType.find(params[:id])
  end

  def new
    @period_quotation_type = PeriodQuotationType.new
  end

  def edit
    @period_quotation_type = PeriodQuotationType.find(params[:id])
  end

  def create
    @period_quotation_type = PeriodQuotationType.new(period_quotation_type_params)

    if @period_quotation_type.save
      redirect_to @period_quotation_type
    else
      render 'new'
    end
  end

  def update
    @period_quotation_type = PeriodQuotationType.find(params[:id])

    if @period_quotation_type.update(period_quotation_type_params)
      redirect_to @period_quotation_type
    else
      render 'edit'
    end
  end

  def destroy
    @period_quotation_type = PeriodQuotationType.find(params[:id])
    @period_quotation_type.destroy

    redirect_to period_quotation_types_path 
  end

  private

  def period_quotation_type_params
    params.require(:period_quotation_type).permit(:short_name, :long_name, :time_interval_id, :count_intervals)
  end

end
