require 'spec_helper'

describe SiteConfig do

    context "To test it must" do
        it "have a valid factory" do
            expect(FactoryGirl.build :site_config).to be_valid
        end

        it "report when invalid" do
            expect(FactoryGirl.build :site_config, default_us_price: nil).to_not be_valid
        end
    end

    context "When saving pricing information" do
        let(:config) {FactoryGirl.create :site_config, default_us_price: 600}
    end

end
