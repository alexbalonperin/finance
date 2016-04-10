require 'rails_helper'

RSpec.describe "markets/show", type: :view do
  before(:each) do
    @market = assign(:market, create(:market))
  end

  it "renders attributes in <p>" do
    render
  end
end
