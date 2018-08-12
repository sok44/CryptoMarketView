require "rails_helper"

describe Quotation do  
  describe "validations" do
    it { should validate_presence_of :currency_pair_id } 
    it { should validate_presence_of :market_id } 
    it { should validate_presence_of :period_quotation_type_id } 
    it { should validate_presence_of :datetime_tick } 
    it { should validate_presence_of :open_tick } 
    it { should validate_presence_of :high_tick } 
    it { should validate_presence_of :low_tick } 
    it { should validate_presence_of :close_tick } 
    it { should validate_presence_of :volume_tick } 
  end

  describe "associations" do
    it { should belong_to :currency_pair}
    it { should belong_to :market}
    it { should belong_to :period_quotation_type}
  end
end