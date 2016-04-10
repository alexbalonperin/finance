require 'rails_helper'

RSpec.describe "historical_data/edit", type: :view do
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

  it "renders the edit historical_datum form" do
    render

    assert_select "form[action=?][method=?]", historical_datum_path(@historical_datum), "post" do

      assert_select "input#historical_datum_open[name=?]", "historical_datum[open]"

      assert_select "input#historical_datum_high[name=?]", "historical_datum[high]"

      assert_select "input#historical_datum_low[name=?]", "historical_datum[low]"

      assert_select "input#historical_datum_close[name=?]", "historical_datum[close]"

      assert_select "input#historical_datum_volume[name=?]", "historical_datum[volume]"

      assert_select "input#historical_datum_adjusted_close[name=?]", "historical_datum[adjusted_close]"

      assert_select "input#historical_datum_company_id[name=?]", "historical_datum[company_id]"
    end
  end
end
