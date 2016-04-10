require 'rails_helper'

RSpec.describe "markets/index", type: :view do
  before(:each) do
    assign(:markets, [
      create(:market),
      create(:market)
    ])
  end

  it "renders a list of markets" do
    render
  end
end
