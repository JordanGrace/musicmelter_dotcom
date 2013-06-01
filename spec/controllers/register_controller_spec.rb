require 'spec_helper'

describe RegisterController do

  describe "GET 'business'" do
    it "returns http success" do
      get 'business'
      response.should be_success
    end
  end

  describe "GET 'user'" do
    it "returns http success" do
      get 'user'
      response.should be_success
    end
  end

end
