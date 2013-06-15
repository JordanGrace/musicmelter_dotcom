require "spec_helper"

describe BusinessAccountsController do
  describe "routing" do

    it "routes to #index" do
      get("/business_accounts").should route_to("business_accounts#index")
    end

    it "routes to #new" do
      get("/business_accounts/new").should route_to("business_accounts#new")
    end

    it "routes to #show" do
      get("/business_accounts/1").should route_to("business_accounts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/business_accounts/1/edit").should route_to("business_accounts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/business_accounts").should route_to("business_accounts#create")
    end

    it "routes to #update" do
      put("/business_accounts/1").should route_to("business_accounts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/business_accounts/1").should route_to("business_accounts#destroy", :id => "1")
    end

  end
end
