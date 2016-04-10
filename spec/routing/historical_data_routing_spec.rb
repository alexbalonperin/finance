require "rails_helper"

RSpec.describe HistoricalDataController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/historical_data").to route_to("historical_data#index")
    end

    it "routes to #new" do
      expect(:get => "/historical_data/new").to route_to("historical_data#new")
    end

    it "routes to #show" do
      expect(:get => "/historical_data/1").to route_to("historical_data#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/historical_data/1/edit").to route_to("historical_data#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/historical_data").to route_to("historical_data#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/historical_data/1").to route_to("historical_data#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/historical_data/1").to route_to("historical_data#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/historical_data/1").to route_to("historical_data#destroy", :id => "1")
    end

  end
end
