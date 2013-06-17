require 'spec_helper'

describe TermsController do

  describe "GET 'refund'" do
    it "returns http success" do
      get 'refund'
      response.should be_success
    end
  end

  describe "GET 'privacy'" do
    it "returns http success" do
      get 'privacy'
      response.should be_success
    end
  end

end
