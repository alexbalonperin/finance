require 'rails_helper'

RSpec.describe "industries/show", type: :view do
  before(:each) do
    @industry = assign(:industry, create(:industry))
  end

  it "renders attributes in <p>" do
    render
  end
end
