require "rails_helper"

describe Quotations::QuotationsSave do

  let(:service) { described_class.new(quotation, params) } 
  
  let(:market) { create(:market) }
  let(:currency_pair) { create(:currency_pair) }

  let(:period_quotation_type) { create(:period_quotation_type) }

  context 'Set valid quotation data.' do
     
    let(:quotation) { Quotation.new }
    let(:params) {
      {market_id: market.id, currency_pair_id: currency_pair.id, period_quotation_type_id: period_quotation_type.id, datetime_tick: "2018-07-16", open_tick: 0.070760, high_tick: 0.071831, low_tick: 0.070170, close_tick: 0.071204, volume_tick: 49558.547}
    }
   
    it 'Save valid data.' do
      #byebug
      expect(service.call).to eq(true)
    end

    it 'Not save not unique record.' do
    
      quotation_first = Quotation.new(attributes_for(:quotation))
      quotation_first.market_id = market.id
      quotation_first.currency_pair_id = currency_pair.id
      quotation_first.period_quotation_type_id = period_quotation_type.id
      quotation_first.save
      
      #byebug
      expect(service.call).to eq(false)
    end

  end

  context 'Set invalid quotation data.' do

    let(:quotation) { Quotation.new }
    let(:params) { {} }
   
    it 'Not save invalid data.' do
      #byebug
      expect(service.call).to eq(false)
    end

  end

end