require 'rails_helper'

RSpec.describe "sectors/new", type: :view do
  before(:each) do
    assign(:sector, Sector.new())
  end

  it "renders new sector form" do
    render

    assert_select "form[action=?][method=?]", sectors_path, "post" do
    end
  end
end
