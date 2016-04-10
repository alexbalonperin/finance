require 'rails_helper'

RSpec.describe "industries/index", type: :view do
  before(:each) do
    assign(:industries, [
      create(:industry),
      create(:industry)
    ])
  end

  it "renders a list of industries" do
    render
  end
end
