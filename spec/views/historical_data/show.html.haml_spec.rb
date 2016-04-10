require 'rails_helper'

RSpec.describe "historical_data/show", type: :view do
  before(:each) do
    @historical_datum = assign(:historical_datum, HistoricalDatum.create!(
      :open => "9.99",
      :high => "9.99",
      :low => "9.99",
      :close => "9.99",
      :volume => 1,
      :adjusted_close => "9.99",
      :company => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
