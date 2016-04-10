require 'rails_helper'

RSpec.describe "historical_data/index", type: :view do
  before(:each) do
    assign(:historical_data, [
      HistoricalDatum.create!(
        :open => "9.99",
        :high => "9.99",
        :low => "9.99",
        :close => "9.99",
        :volume => 1,
        :adjusted_close => "9.99",
        :company => nil
      ),
      HistoricalDatum.create!(
        :open => "9.99",
        :high => "9.99",
        :low => "9.99",
        :close => "9.99",
        :volume => 1,
        :adjusted_close => "9.99",
        :company => nil
      )
    ])
  end

  it "renders a list of historical_data" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
