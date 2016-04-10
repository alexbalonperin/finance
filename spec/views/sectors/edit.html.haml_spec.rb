require 'rails_helper'

RSpec.describe "sectors/edit", type: :view do
  before(:each) do
    @sector = assign(:sector, Sector.create!())
  end

  it "renders the edit sector form" do
    render

    assert_select "form[action=?][method=?]", sector_path(@sector), "post" do
    end
  end
end
