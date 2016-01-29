require 'spec_helper'

describe "reservations/index" do
  before(:each) do
    assign(:reservations, [
      stub_model(Reservation,
        :user => nil,
        :event => nil
      ),
      stub_model(Reservation,
        :user => nil,
        :event => nil
      )
    ])
  end

  it "renders a list of reservations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
