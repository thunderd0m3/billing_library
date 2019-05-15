require 'spec_helper'
require 'json'
require_relative '../app/lib/report_generator.rb'

RSpec.describe ReportGenerator do
  let(:reseller) { Reseller.new("a_reseller", 100.0) }
  let(:affiliate) { Affiliate.new("an_affiliate", 65.0) }
  let(:sellers) { [reseller, affiliate] }
  let(:direct_sales) { 100 }

  before do
    reseller.order_widgets(50)
    affiliate.order_widgets(75)
  end

  describe ".billing" do
    subject do
      described_class.billing(sellers: sellers)
    end

    it "returns report generated by BillingReport" do
      expect(BillingReport).to receive(:generate).with(sellers: sellers)
      subject
    end
  end

  describe ".seller_profits" do
    subject do
      described_class.seller_profits(sellers: sellers)
    end

    it "returns report generated by SellerProfitsReport" do
      expect(SellerProfitsReport).to receive(:generate).with(sellers: sellers)
      subject
    end
  end

  describe ".company_revenue" do
    subject do
      described_class.company_revenue(
        sellers: sellers,
        direct_sales: direct_sales
      )
    end

    it "returns report generated by CompanyRevenueReport" do
      expect(CompanyRevenueReport).to receive(:generate)
        .with(sellers: sellers, direct_sales: direct_sales)
      subject
    end
  end
end
