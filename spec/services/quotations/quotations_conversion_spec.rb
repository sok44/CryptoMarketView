require "rails_helper"

describe Quotations::QuotationConversion do

  let(:testing_module) { Class.new.include(described_class).new }

  let(:market) { create(:market) }
  let(:currency_pair) { create(:currency_pair) }

  describe '#get_precision' do
    
    context 'Precision get from quote_currency.' do

      #get_precision(currency_pair_id, market_id, type_precision) 
      it 'Get tick_precision.' do
        expect(testing_module.get_precision(currency_pair.id, market.id, :tick_precision)).to eq(currency_pair.quote_currency.tick_precision)
      end

      it 'Get volume_precision.' do
        expect(testing_module.get_precision(currency_pair.id, market.id, :volume_precision)).to eq(currency_pair.quote_currency.volume_precision)
      end
    end

    context 'Precision get from market_symbol_precision.' do

      #let!(:market_symbol_precision) do
      #  MarketSymbolPrecision.create(attributes_for(:market_symbol_precision)) do |market_symbol_precision|
      #    market_symbol_precision.market_id = market.id
      #    market_symbol_precision.currency_pair_id = currency_pair.id
      #  end
      #end

      let(:market_symbol_precision) { create(:market_symbol_precision) }
    
      it 'Get tick_precision.' do
        expect(testing_module.get_precision(market_symbol_precision.currency_pair.id, market_symbol_precision.market.id, :tick_precision)).to eq(market_symbol_precision.tick_precision)
      end

      it 'Get volume_precision.' do
        expect(testing_module.get_precision(market_symbol_precision.currency_pair.id, market_symbol_precision.market.id, :volume_precision)).to eq(market_symbol_precision.volume_precision)
      end
    end

    context 'Precision not set in DB' do

      it 'Get null tick_precision.' do
        expect(testing_module.get_precision(nil, nil, :tick_precision)).to eq(nil)
      end

      it 'Get null volume_precision.' do
        expect(testing_module.get_precision(nil, nil, :volume_precision)).to eq(nil)
      end

    end
  end

  describe '#convert_before_save' do  
    context 'Method convert_before_save.' do
      it 'Value and precision is not nil. lenght_fractional_part < count_precision.' do
        expect(testing_module.convert_before_save(10.012345, currency_pair.id, market.id, :tick_precision)).to eq(1001234500)
      end

      it 'Value and precision is not nil. lenght_fractional_part < count_precision, only fractional_part.' do
        expect(testing_module.convert_before_save(0.012345, currency_pair.id, market.id, :tick_precision)).to eq(1234500)
      end

      it 'Value and precision is not nil. lenght_fractional_part > count_precision.' do
        expect(testing_module.convert_before_save(10.0123456789, currency_pair.id, market.id, :tick_precision)).to eq(1001234567)
      end

      it 'Value and precision is not nil. lenght_fractional_part > count_precision, only fractional_part.' do
        expect(testing_module.convert_before_save(0.0123456789, currency_pair.id, market.id, :tick_precision)).to eq(1234567)
      end

      it 'Value and precision is not nil. lenght_fractional_part = count_precision.' do
        expect(testing_module.convert_before_save(10.01234567, currency_pair.id, market.id, :tick_precision)).to eq(1001234567)
      end

      it 'Value and precision is not nil. lenght_fractional_part = count_precision, only fractional_part.' do
        expect(testing_module.convert_before_save(0.01234567, currency_pair.id, market.id, :tick_precision)).to eq(1234567)
      end

      it 'Value is nil.' do
        expect(testing_module.convert_before_save(nil, currency_pair.id, market.id, :tick_precision)).to eq(nil)
      end

      it 'Precision is nil.' do
        expect(testing_module.convert_before_save(0.070760, nil, nil, :tick_precision)).to eq(nil)
      end
    end
  end

  describe '#convert_before_view' do  
    context 'Method convert_before_view.' do
      it 'Value and precision is not nil.' do
        expect(testing_module.convert_before_view(7076000, currency_pair.id, market.id, :tick_precision)).to eq(0.070760)
      end

      it 'Value is nil.' do
        expect(testing_module.convert_before_view(nil, currency_pair.id, market.id, :tick_precision)).to eq(nil)
      end

      it 'Precision is nil.' do
        expect(testing_module.convert_before_view(7076000, nil, nil, :tick_precision)).to eq(nil)
      end
    end
  end

end