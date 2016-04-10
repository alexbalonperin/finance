require 'rails_helper'

RSpec.describe "countries/index", type: :view do
  before(:each) do
    assign(:countries, [
      create(:country),
      create(:country)
    ])
  end

  it "renders a list of countries" do
    render
  end
end
