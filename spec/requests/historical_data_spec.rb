require 'rails_helper'

RSpec.describe "HistoricalData", type: :request do

  let(:company) { FactoryGirl.create(:company) }

  describe "GET /historical_data" do
    it "works! (now write some real specs)" do
      get company_historical_data(company.id)
      expect(response).to have_http_status(200)
    end
  end
end
